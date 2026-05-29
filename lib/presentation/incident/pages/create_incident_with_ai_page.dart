import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident_category.dart';
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/pages/select_mode_page.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/error_widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/secondary_button.widget.dart';
import 'package:inspector/presentation/core/widget/shimmer_widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:inspector/presentation/incident/blocs/get_incident_types_bloc/get_incident_types_bloc.dart';
import 'package:inspector/presentation/incident/blocs/hilight_item_bloc/highlight_item_bloc.dart';
import 'package:inspector/presentation/incident/pages/chat_with_ai_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/validation.dart';

class CreateIncidentWithAiPage  extends StatefulWidget {

  final LatLng latLng;

  const CreateIncidentWithAiPage({
    required this.latLng,
    super.key});


  @override
  State<CreateIncidentWithAiPage> createState() => _CreateIncidentWithAiState();
}

class _CreateIncidentWithAiState extends State<CreateIncidentWithAiPage> with ScreenUtils {

  GetIncidentTypesBloc getIncidentTypesBloc = getIt<GetIncidentTypesBloc>();

  IncidentType? type;
  IncidentCategory? _selectedIncidentCategory;
  TextEditingController descriptionController = TextEditingController(
    text: 'ask_for_the_appropriate_report_type'.tr()
  );
  bool hideInfo=false;

  @override
  void initState() {
    getIncidentTypesBloc.add(GetIncidentTypesRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


     const _backgroundColor = Color(0xFFF15BB5);

     const _colors = [
      Color(0xFFFEE440),
      Color(0xFF00BBF9),
    ];

     const _durations = [
      5000,
      4000,
    ];

     const _heightPercentages = [
      0.65,
      0.66,
    ];



    return Scaffold(
      appBar:AppBarWidget(titleWidget: Text('report_an_outage'.tr())),
      body:SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('is_the_report_about'.tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20
              ),),
            const SizedBox(
              height: 23,
            ),


            BlocConsumer<GetIncidentTypesBloc, BaseState<List<IncidentType>>>(
                bloc: getIncidentTypesBloc,
                listener: (context,state){
                  if(state.isSuccess){

                    if (state.item != null) {
                      for (final e in state.item!) {
                        if (e.key == 'electricity_theft') {
                          type = e;
                          break;
                        }
                      }
                    }
                    List<IncidentCategory> types = type?.categories ?? [];

                    _selectedIncidentCategory = types[0];

                    setState(() {

                    });

                  }
                },
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

                      },
                    );


                  }
                  return const SizedBox.shrink();
                }),

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
                color: AppColors.background,

                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1), // x: 0px, y: 1px
                    blurRadius: 1,        // blur: 2px
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.06), // #0000000F ≈ 6%
                  ),
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.10), // #0000001A ≈ 10%
                  ),
                ],
              ),



              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,

                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration:  const BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Assets.icons.electricity.image(
                            width: 16,
                            height: 16,
                            color: AppColors.primaryColor
                        ),
                      ),
                    ),
                    title:  Text('spark_or_strange_sound'.tr(),
                      style: const TextStyle(
                          color:AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                    trailing:Assets.icons.edit1.image(

                    ),
                  ),
                  const SizedBox(height: 13,),

                  ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,

                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Assets.icons.electricity.image(
                            width: 16,
                            height: 16,
                            color: AppColors.primaryColor
                        ),
                      ),
                    ),
                    title: Text('power_outage'.tr(),
                      style: const TextStyle(
                          color:AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),),
                    trailing:Assets.icons.edit1.image(

                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),




            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 1,
                    color: AppColors.borderColor
                ),
                color: AppColors.background,

                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1), // x: 0px, y: 1px
                    blurRadius: 1,        // blur: 2px
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.06), // #0000000F ≈ 6%
                  ),
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.10), // #0000001A ≈ 10%
                  ),
                ],
              ),



              padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'problem_description'.tr(),
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 13,),
                  Builder(
                      builder: (context) {

                        return Container(

                          child: TextFieldWidget(

                            validator:(value)=> Validation.required(value),
                            controller: descriptionController,
                            contentPadding: const EdgeInsets.all(0 ),
                            hintText: 'problem_description'.tr(),
                            fillColor: Colors.transparent,
                            maxLines: 4,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            inputBorder: InputBorder.none,
                              disabledBorder:InputBorder.none
                          ),
                        );
                      }
                  ),

                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),



            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 1,
                    color: AppColors.borderColor
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'geographic_location'.tr() +': ${widget.latLng.latitude.toStringAsFixed(6)},${widget.latLng.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  Center(
                    child: Assets.icons.edit1.image(
                        width: 24,
                        height: 24,
                        color: AppColors.primaryColor
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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

          ],

        ),
      ),

      bottomNavigationBar: SizedBox(
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

                  if(descriptionController.text.isEmpty){
                    showError(customMessage: 'enter_the_problem_description'.tr());
                    return;
                  }






                  showSuccess(customMessage: 'incident_created_successfully'.tr());


                  int count = 0;
                  context.router.popUntil((_) => count++ >= 3);

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
