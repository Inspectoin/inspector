import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/entities/incident_category.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/pages/select_mode_page.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/error_widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/shimmer_widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:inspector/presentation/incident/blocs/create_incident_bloc/create_incident_bloc.dart';
import 'package:inspector/presentation/incident/blocs/get_incident_types_bloc/get_incident_types_bloc.dart';
import 'package:inspector/presentation/incident/blocs/hilight_item_bloc/highlight_item_bloc.dart';
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart';
import 'package:inspector/presentation/incident/widget/custom_upload_files_widget.dart';
import 'package:inspector/presentation/incident/widget/image_upload_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class PowerOutageIncidentPage extends StatefulWidget {
  final LatLng latLng;
  const PowerOutageIncidentPage({
    required this.latLng,
    super.key});

  @override
  State<PowerOutageIncidentPage> createState() => _PowerOutageIncidentPageState();
}

class _PowerOutageIncidentPageState extends State<PowerOutageIncidentPage> with ScreenUtils,ScreenLoader {
  GetIncidentTypesBloc getIncidentTypesBloc = getIt<GetIncidentTypesBloc>();
  CreateIncidentBloc createIncidentBloc = getIt<CreateIncidentBloc>();
  IncidentType? type;
  IncidentCategory? _selectedIncidentCategory;

  TextEditingController descriptionController = TextEditingController();


  List<IncidentFile> files =[];
  List<UploadIncidentFileBloc> filesBlocs =[];

  @override
  void initState() {
    if (!getIncidentTypesBloc.state.isSuccess) {
      getIncidentTypesBloc.add(GetIncidentTypesRequested());
    }
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(
          titleWidget: Text(
        'report_an_outage'.tr(),
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BlocListener<CreateIncidentBloc, BaseState<Incident>>(
              bloc: createIncidentBloc,
              listener: (context,state){

                if(state.isInProgress){
                  startLoading();
                }else if(state.isFailure){
                  stopLoading();
                  showError(failure: state.failure);
                }else if(state.isSuccess){
                  stopLoading();
                  showSuccess(customMessage: 'incident_created_successfully'.tr());


                  int count = 0;
                  context.router.popUntil((_) => count++ >= 2);
                }


              },
              child: const SizedBox.shrink(),),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: AppColors.borderColor
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'geographic_location'.tr()+': ${widget.latLng.latitude.toStringAsFixed(6)},${widget.latLng.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Center(
                    child: Assets.icons.location.image(
                      width: 20,
                      height: 20,
                      color: AppColors.primaryColor
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<GetIncidentTypesBloc, BaseState<List<IncidentType>>>(
                bloc: getIncidentTypesBloc,
                builder: (context, state) {
                  if (state.isInProgress) {
                    return ListView.separated(
                        itemCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ShimmerWidget.rectangular(
                            height: 64,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        });
                  }

                  if (state.isFailure) {
                    return CustomErrorWidget(
                      failure: state.failure,
                      onRetry: () {
                        getIncidentTypesBloc.add(GetIncidentTypesRequested());
                      },
                    );
                  }

                  if (state.isSuccess) {

                    if (state.item != null) {
                      for (final e in state.item!) {
                        if (e.key == 'malfunction') {
                          type = e;
                          break;
                        }
                      }
                    }
                    List<IncidentCategory> types = type?.categories ?? [];


                    return ListView.separated(
                        itemCount: types.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final category = types[index];

                          return CheckBoxListTileWidget(
                            title: category.name,
                            isCheck: _selectedIncidentCategory == category ,
                            onChanged: (value){
                              setState(() {
                                _selectedIncidentCategory = category;
                              });
                            },
                          );
                          return SizedBox(
                            height: 64,
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: _selectedIncidentCategory == category
                                        ? AppColors.primaryColor
                                        : Colors.black,
                                    width: _selectedIncidentCategory == category ? 1.5 : 1,
                                  )),
                              child: RadioListTile<IncidentCategory>(
                                dense: true,

                                controlAffinity: ListTileControlAffinity.trailing,
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration:  BoxDecoration(
                                        color: _selectedIncidentCategory == category
                                            ? const Color(0xFFdce8fe):const Color(0xFFefeff0),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Assets.icons.electricity.image(
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      category.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                value: category,
                                groupValue: _selectedIncidentCategory,
                                onChanged: (IncidentCategory? value) {
                                  setState(() {
                                    _selectedIncidentCategory = value;
                                  });
                                },
                                tileColor: Colors.white,
                                activeColor: AppColors.primaryColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        });
                  }
                  return const SizedBox.shrink();
                }),
            const SizedBox(height: 20),
            Text(
              'problem_description'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {

                return Container(
                  decoration: BoxDecoration(


                    boxShadow:const [
                      BoxShadow(
                        color:  Color(0x1A000000), // #0000001A (black with 10% opacity)
                        offset:  Offset(0, 1),     // x=0, y=1
                        blurRadius: 3,                  // 3px blur
                        spreadRadius: 0,                // same as in CSS
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFieldWidget(

                    validator:(value)=> Validation.required(value),
                    controller: descriptionController,
                   contentPadding: const EdgeInsets.all(20 ),
                   hintText: 'problem_description'.tr(),

                    maxLines: 5,
                  ),
                );
              }
            ),
            const SizedBox(height: 20),
            Text(
              'add_photos_optional'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),




            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0),
              child: CustomUploadFilesWidget(
                boxColor: const Color.fromRGBO(
                    255, 252, 255, 1),
                borderColor: AppColors.primaryColor,
                files: files,
                filesCubits: filesBlocs,
                maxFilesCount: 20,
                onChange: (){setState(() {});},
                onFileUploaded: (){
                  setState(() {});
                },
              ),
            )



          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [

            const SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){





                  if(_selectedIncidentCategory==null){
                    showError(customMessage: 'choose_the_type_of_fault'.tr());
                    return;
                  }

                  if(descriptionController.text.trim().isEmpty){
                    showError(customMessage: 'enter_the_problem_description'.tr());
                    return;
                  }


                  if(!SelectModePage.isGuestMode){
                    context.router.navigate(HistoryRoute());
                    getIt<HighlightItemBloc>().add(HighlightItemRequested(type: HighlightItemType.incident));

                  }
                  showSuccess(customMessage: 'incident_created_successfully'.tr());

                  int count = 0;
                  context.router.popUntil((_) => count++ >= 2);
                },
                child: Text('send_report'.tr() ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}


class CheckBoxListTileWidget extends StatelessWidget {
  final bool isCheck;
  final String title;
  final Function(bool) onChanged;
  const CheckBoxListTileWidget({
    required this.title,
    required this.isCheck,
    required this.onChanged,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      borderRadius:  BorderRadius.circular(12),
      onTap: (){
        onChanged(!isCheck);
      },
      child: Container(

          decoration: BoxDecoration(
            color: isCheck
                ? AppColors.primaryColor:const Color(0xFFF9F9F9),
            border: Border.all(
              color: const Color(0x1A0E2A2A), // #0E2A2A1A = ARGB
              width: 1,                       // 1px
            ),
            boxShadow:const [
               BoxShadow(
                color:  Color(0x1A000000), // #0000001A (black with 10% opacity)
                offset:  Offset(0, 1),     // x=0, y=1
                blurRadius: 3,                  // 3px blur
                spreadRadius: 0,                // same as in CSS
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),

        child: ListTile(
          contentPadding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 5
          ),
          leading: Container(
            width: 38,
            height: 38,
            decoration:  BoxDecoration(
              color: isCheck
                  ? Colors.white:const Color(0xFFF9F9F9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Assets.icons.electricity.image(
                width: 16,
                height: 16,
                color: isCheck? AppColors.primaryColor:AppColors.primaryColor
              ),
            ),
          ),
          title: Text(title,
        style: TextStyle(
          color:isCheck? Colors.white:AppColors.primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 16
        ),),
          trailing: Checkbox(value: isCheck,
              splashRadius:2 ,
              side: const BorderSide(color: Color(0xFFe6eaea), width: 2), // border when unchecked


              checkColor: AppColors.primaryColor,
              fillColor: WidgetStateProperty.all(Colors.white),
              onChanged: (value){
            onChanged(value??false);
          }),
      )),
    );
  }
}
