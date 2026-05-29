import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspector/app.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:inspector/presentation/incident/widget/add_facility_bottom_sheet.dart';

@RoutePage()
class AddFacilityPage extends StatefulWidget {
  const AddFacilityPage({super.key});

  @override
  State<AddFacilityPage> createState() => _AddFacilityPageState();
}

class _AddFacilityPageState extends State<AddFacilityPage> {


  bool isMainBranch=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleWidget: Text('add_facility'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('main_branch'.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                          value: isMainBranch, onChanged: (value){
                        setState(() {
                          isMainBranch=value??false;
                        });
                      }),
                    )
                  ],
                ),
              )),
            const SizedBox(height: 24,),
            Text('facility_data'.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),),
            const SizedBox(height: 16,),




            Wrap(
              children: [
                Text('parent_facility'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                const SizedBox(width: 5,),
                Text('*',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    color: Color(0xFFFB3748)
                  ),),

              ],
            ),
            TextFieldWidget(
              hintText: 'parent_facility'.tr(),
            ),
            const SizedBox(height: 16,),


            Wrap(
              children: [
                Text('activity'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                const SizedBox(width: 5,),
                Text('*',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    color: Color(0xFFFB3748)
                  ),),

              ],
            ),
            TextFieldWidget(
              hintText: 'activity'.tr(),
            ),
            const SizedBox(height: 16,),



            Wrap(
              children: [
                Text('facility_type'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                const SizedBox(width: 5,),
                Text('*',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFB3748)
                  ),),

              ],
            ),
            TextFieldWidget(
              hintText: 'facility_type'.tr(),
            ),
            const SizedBox(height: 16,),


            Wrap(
              children: [
                Text( 'branch'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                const SizedBox(width: 5,),
                Text('*',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFB3748)
                  ),),

              ],
            ),
            TextFieldWidget(
              hintText: 'branch'.tr()
            ),
            const SizedBox(height: 16,),



            Wrap(
              children: [
                Text( 'arabic_name'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                const SizedBox(width: 5,),
                Text('*',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFB3748)
                  ),),

              ],
            ),
            TextFieldWidget(
              hintText: 'arabic_name'.tr(),
            ),
            const SizedBox(height: 16,),


            Wrap(
              children: [
                Text('english_name'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
                // const SizedBox(width: 5,),
                // Text('*',
                //   style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w600,
                //       color: Color(0xFFFB3748)
                //   ),),

              ],
            ),
            TextFieldWidget(
              hintText: 'english_name'.tr(),
            ),
            const SizedBox(height: 16,),


            Wrap(
              children: [
                Text( 'facility_weight'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),


              ],
            ),
            TextFieldWidget(
              hintText: 'facility_weight'.tr(),
            ),
            const SizedBox(height: 16,),


            Wrap(
              children: [

                Text('unified_id_number'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),
              ],
            ),
            TextFieldWidget(
              hintText: 'unified_id_number'.tr(),
            ),
            const SizedBox(height: 16,),


            Wrap(
              children: [
                Text('commercial_registration_number'.tr(),
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),),

              ],
            ),
            TextFieldWidget(
              hintText:'commercial_registration_number'.tr(),
            ),
            const SizedBox(height: 16,),

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
                color: Color(0xFF1FC16B),
                onPressed: (){




                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: false,
                    builder: (context) => const AddFacilityBottomSheet(),
                  );



                },
                child: Wrap(
                  children: [
                    Assets.icons.addSquare.image(
                        color: Colors.white,
                        width: 24
                    ),
                    const SizedBox(width: 10,),

                    Text('create'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,

                      ),),

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
