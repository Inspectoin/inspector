import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/auth/pages/select_mode_page.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/error_widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/secondary_button.widget.dart';
import 'package:inspector/presentation/core/widget/shimmer_widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:inspector/presentation/incident/blocs/hilight_item_bloc/highlight_item_bloc.dart';
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart';
import 'package:inspector/presentation/incident/widget/custom_upload_files_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inspector/domain/incident/entities/incident_category.dart';
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/incident/blocs/create_incident_bloc/create_incident_bloc.dart';
import 'package:inspector/presentation/incident/blocs/get_incident_types_bloc/get_incident_types_bloc.dart';

class ElectricityTheftIncidentPage extends StatefulWidget {
  final LatLng latLng;

  const ElectricityTheftIncidentPage({
    required this.latLng,
    super.key});

  @override
  State<ElectricityTheftIncidentPage> createState() => _ElectricityTheftIncidentPageState();
}

class _ElectricityTheftIncidentPageState extends State<ElectricityTheftIncidentPage> with ScreenUtils,ScreenLoader {

  GetIncidentTypesBloc getIncidentTypesBloc = getIt<GetIncidentTypesBloc>();
  CreateIncidentBloc createIncidentBloc = getIt<CreateIncidentBloc>();
  IncidentType? type;
  IncidentCategory? _selectedIncidentCategory;
  TextEditingController descriptionController = TextEditingController();

  List<IncidentFile> files =[];
  List<UploadIncidentFileBloc> filesBlocs =[];


  bool hideInfo=false;
  @override
  void initState() {
   // if (!getIncidentTypesBloc.state.isSuccess) {
      getIncidentTypesBloc.add(GetIncidentTypesRequested());
   // }
    super.initState();
  }


  @override
  Widget screen(BuildContext context) {
    return  Scaffold(
      appBar: AppBarWidget(
          titleWidget: Text(
            'report_electricity_theft'.tr(),
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

            Text('is_the_report_about'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20
            ),),
            const SizedBox(
              height: 18,
            ),


            BlocBuilder<GetIncidentTypesBloc, BaseState<List<IncidentType>>>(
                bloc: getIncidentTypesBloc,
                builder: (context, state) {

                  if (state.isInProgress) {

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2, // Show 6 shimmer items
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 1, // Adjust aspect ratio as needed
                      ),
                      itemBuilder: (context, index) {
                        return ShimmerWidget.rectangular(
                          height: 64, // Match your RadioListTile height
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        );
                      },
                    );
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
                        if (e.key == 'electricity_theft') {
                          type = e;
                          break;
                        }
                      }
                    }
                    List<IncidentCategory> types = type?.categories ?? [];


                    return GridView.builder(
                      shrinkWrap: true,

                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: types.length, // Show 6 shimmer items
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 1, // Adjust aspect ratio as needed
                      ),
                      itemBuilder: (context, index) {

                        return ChoiceCard(
                          isChecked: _selectedIncidentCategory?.name==types[index].name,
                          title:'${types[index].name}' ,
                          onChange: (){
                            setState(() {
                              _selectedIncidentCategory = types[index];
                            });
                          },
                        );
                          if(_selectedIncidentCategory?.name==types[index].name){
                            return Container(

                              child: PrimaryButton(onPressed: (){
                                setState(() {
                                  _selectedIncidentCategory = types[index];
                                });
                              }, child: Text('${types[index].name}')),
                            );
                          }
                        return SecondaryButtonWidget(onPressed: (){
                          setState(() {
                            _selectedIncidentCategory = types[index];
                          });
                        }, child: Text('${types[index].name}'));
                      },
                    );


                  }
                  return const SizedBox.shrink();
                }),
            const SizedBox(
              height: 18,
            ),
            CheckboxListTile(

              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                title: Row(
                  children: [
                    Assets.icons.anonymousIcon.image(),
                    const SizedBox(width: 10,),
                     Text('send_anonymously'.tr(),
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
                side: const BorderSide(color: Color(0xff929393), width: 2), // border when unchecked

                value: hideInfo,
                onChanged: (value){
                setState(() {
                  hideInfo=value!;
                });
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





                  // if(_selectedIncidentCategory==null){
                  //   showError(customMessage: 'choose_the_type_of_fault'.tr());
                  //   return;
                  // }
                  //
                  // if(descriptionController.text.isEmpty){
                  //   showError(customMessage: 'enter_the_problem_description'.tr());
                  //   return;
                  // }






                  showSuccess(customMessage: 'incident_created_successfully'.tr());


                  int count = 0;
                  context.router.popUntil((_) => count++ >= 2);

                  if(!SelectModePage.isGuestMode){
                    context.router.navigate(HistoryRoute());
                    getIt<HighlightItemBloc>().add(HighlightItemRequested(type: HighlightItemType.incident));

                  }
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


class ChoiceCard extends StatelessWidget {
  final String title;
  final Function onChange;
  final bool isChecked;
  const ChoiceCard({
    required this.title,
    required this.onChange,
    required this.isChecked,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        onChange();
      },
      child: Container(
        decoration: BoxDecoration(
          color:isChecked? AppColors.primaryColor: Colors.white,
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
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Assets.icons.iconFile.image(
            //   width: 20
            // ),
            // const SizedBox(width: 10,),
            Text(title,
            style: TextStyle(
              color:isChecked? Colors.white: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18

            ),)
          ],
        ),
      ),
    );
  }
}
