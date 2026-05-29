import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddFacilityBottomSheet extends StatefulWidget {
  const AddFacilityBottomSheet({super.key});

  @override
  State<AddFacilityBottomSheet> createState() => _AddFacilityBottomSheetState();
}

class _AddFacilityBottomSheetState extends State<AddFacilityBottomSheet> {


  int selectedIndex=-1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,

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

            Container(
              width: 80,
              height: 80,
              decoration:  const BoxDecoration(
                color:  Color(0xFFe7fdf2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Assets.icons.buildingBig.image(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'operation_successful'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text('facility_added_al_nakheel_hotel'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                  decoration: BoxDecoration(
                      color: Color(0xFFf9f9f9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Color(0xffd6d5d5)
                      )
                  ),
                  child:  Center(
                    child: Text('license_number_rest002'.tr(),
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                      ),),
                  ),
                ),
              ],
            ),






            const SizedBox(height: 40),

            SizedBox(
                height: 40,
                child: PrimaryButton(onPressed: (){

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();


                }, child: Wrap(
                  children: [

                    Assets.icons.tickCircle.image(
                      width: 24,
                    ),
                    const SizedBox(width: 10,),
                    Text('ok'.tr()),
                  ],
                )))
          ],
        ),
      ),
    );
  }


}
