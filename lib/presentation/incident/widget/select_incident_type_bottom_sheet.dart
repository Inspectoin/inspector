import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectIncidentTypeBottomSheet extends StatefulWidget {
  const SelectIncidentTypeBottomSheet({super.key});

  @override
  State<SelectIncidentTypeBottomSheet> createState() => _SelectIncidentTypeBottomSheetState();
}

class _SelectIncidentTypeBottomSheetState extends State<SelectIncidentTypeBottomSheet> {


  int selectedIndex=-1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000), // #00000040
            offset: const Offset(0, -3),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'submit_a_request'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text('please_select_the_type_of_operation_that_serves_your_request'.tr()),

            const SizedBox(height: 20),






            _buildMiniButton(title: 'report_an_outage'.tr(),
                isChecked: selectedIndex==0,
                onTap: (){
              selectedIndex=0;

              setState(() {

              });
             //

            }),
            const SizedBox(height: 20),

            _buildMiniButton(title: 'theft_of_electricity'.tr(),
                isChecked: selectedIndex==1,

                onTap: (){
              selectedIndex=1;
              setState(() {
              });
             //
            }),
            const SizedBox(height: 20),
            _buildMiniButton(title: 'using_ai'.tr(),

                isChecked: selectedIndex==2,
                onTap: (){
                  selectedIndex=2;
                  setState(() {
                  });
              // showError(customMessage: 'adfsad');
            }),
            const SizedBox(height: 20),

            SizedBox(
                height: 40,
                child: PrimaryButton(onPressed: (){

                  Navigator.of(context).pop();
                  if(selectedIndex==0){
                    context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.powerOutage));
                  }else if(selectedIndex==1){
                    context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.electricityTheft));
                  }else if(selectedIndex==2) {
                    context.router.push(const ChatWithAiRoute());
                  }

                }, child: Text('next'.tr())))
          ],
        ),
      ),
    );
  }

  Widget _buildMiniButton( {required String title,required Function onTap,required bool isChecked}) {


    return  SizedBox(
          height: 40,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            color:isChecked ? AppColors.primaryColor: Color(0xffF9F9F9),
            child:InkWell(
              onTap: (){
                onTap();
              },
              child: Container(
                padding: EdgeInsetsDirectional.only(
                  start: 10,
                  end: 15,
                  top: 5,
                  bottom: 5,
                ),

                child:  Container(
                  child: Row(
                      children: [
                        Assets.icons.addSquare.image(width: 20,

                            color:isChecked ? Color(0xffF9F9F9) : AppColors.primaryColor,),

                        const SizedBox(width: 20,),
                        Text(title,
                        style: TextStyle(
                          color:isChecked ? Color(0xffF9F9F9) : AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14
                        ),),
                      ]
                  ),
                ),
              ),
            ),
          ),
        );
  }

}
