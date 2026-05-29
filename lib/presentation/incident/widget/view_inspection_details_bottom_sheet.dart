import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:inspector/presentation/incident/pages/facilities_page.dart';

class ViewInspectionDetailsBottomSheet extends StatefulWidget {
  const ViewInspectionDetailsBottomSheet({super.key});

  @override
  State<ViewInspectionDetailsBottomSheet> createState() => _ViewInspectionDetailsBottomSheetState();
}

class _ViewInspectionDetailsBottomSheetState extends State<ViewInspectionDetailsBottomSheet> {


  int selectedIndex=-1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
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

            const SizedBox(height: 20),

            Text(
              'inspection_plan_goal'.tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Container(
              height: 120,
              padding:const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFf9f9f9),
                  borderRadius: BorderRadius.circular(20),

              ),
              child: Center(
                child: Text('inspection_plan_goal_description'.tr(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),






            const SizedBox(height: 20),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){

                   Navigator.pop(context);

                   context.router.push( FacilitiesRoute(
                     type: FacilitiesPageType.forPlans
                   ));


                },
                child: Wrap(
                  children: [
                    Assets.icons.arrowRightAndroid.image(
                        color: Colors.white,
                        width: 24
                    ),
                    const SizedBox(width: 10,),
                    Text('next'.tr()),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }


}
