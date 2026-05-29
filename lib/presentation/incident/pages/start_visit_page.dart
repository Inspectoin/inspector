import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:inspector/presentation/incident/widget/distance_bottom_sheet.dart';

@RoutePage()
class StartVisitPage extends StatelessWidget {
  const StartVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBarWidget(

          titleWidget: Text(
            "${'the_visit'.tr()} LS00010039",

          ),

        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

                          Text('inspection_lists'.tr(),

            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),),

              const SizedBox(height: 20,),
              // Step Progress Section
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "step_1_of_3".tr(),
              //             style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500 ),
              //           ),
              //           Text(
              //             "${'visit_report'.tr()} VS00010039",
              //             style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500 ),
              //           ),
              //
              //         ],
              //       ),
              //       const SizedBox(height: 8),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "${'completed'.tr()} 01%",
              //             style: TextStyle(fontSize: 12, ),
              //           ),
              //           const SizedBox(width: 12),
              //
              //           Expanded(
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(44),
              //               child: LinearProgressIndicator(
              //                 value: 0.01,
              //                 minHeight: 10,
              //
              //                 backgroundColor: Color(0xFFE5E5E5),
              //                 color:  AppColors.primary2Color,
              //               ),
              //             ),
              //           ),
              //
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Row(
                      children: [

                        Text(
                          "al_nakhil_hotel".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),

                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 10, vertical: 6),
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFe9faf0),
                        //
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Text(
                        //     "in_progress".tr(),
                        //     style: TextStyle(
                        //       color: Color(0xFF009966),
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F7F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "LS00000112",
                            style: TextStyle(
                              color:AppColors.secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),


                      ],
                    ),


                    const SizedBox(height: 16),


                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "water_leak_report_details".tr(),
                            maxLines: 3,
                            style: TextStyle(color: Colors.black87, height: 1.4),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color:AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "active_inspection".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "owner_name".tr(),
                          style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: const Text(
                            "HAMAD NASSER HAMAD ALSHABANAT",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w400,color: Color(0xFF6A7282),
                            fontSize: 14),
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 16),

                    // Info Rows
                    infoRow(
                      label: "date".tr(),
                      value: "23-08-2024",
                      icon: Icons.calendar_today_outlined,
                      color: const Color(0xFFF2E9FF),
                      contentColor: Color(0xFF9a6eba)
                    ),
                    const SizedBox(height: 8),
                    infoRow(
                      label: "time".tr(),
                      value: "14:00",
                      icon: Icons.access_time,
                      color: const Color(0xFFE9F1FF),
                      contentColor: const  Color(0xFF5487cd)
                    ),
                    const SizedBox(height: 8),
                    infoRow(
                      label: "distance".tr(),
                      value: '234_km'.tr(),
                      icon: Icons.location_on_outlined,
                      color: const Color(0xFFe6fcf1),
                      contentColor: Color(0xFF7fad9e)
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),


            ],
          ),
        ),

        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 50,right: 20,left: 20),
          child:   // Bottom Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomButton(
                label: "next".tr(),
                icon: Assets.icons.arrowRightAndroid.image(),
                color: const Color(0xFF1FC16B),
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => const DistanceBottomSheet(),
                  );
                }
              ),

              _bottomButton(
                label: "schedule_visit".tr(),
                icon: Assets.icons.calendarIcon.image(
                    color: Colors.white
                ),
                color: AppColors.secondaryColor,
                onTap: (){}
              ),

              _bottomButton(
                label: "transfer".tr(),
                icon: Assets.icons.programmingArrows.image(),
                color: const Color(0xFF7B60D5),
                onTap: (){}

              ),
            ],
          ),
        ),
      );
  }




  Widget _bottomButton({
    required String label,
    required Widget icon,
    required Color color,
    required Function onTap,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 46,
        child: ElevatedButton.icon(
          onPressed: () {
            onTap();
          },
          icon:icon,
          label: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

Widget infoRow({
  required String label,
  required String value,
  required IconData icon,
  required Color color,
  required Color contentColor,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: Row(
      children: [
        Icon(icon, size: 18, color: contentColor),
        const SizedBox(width: 8),

        Text(
          label,
          style:  TextStyle(color: contentColor, fontSize: 13),
        ),
        const Spacer(),

        Text(
          value,
          style:  TextStyle(fontWeight: FontWeight.w600,color: contentColor),
        ),
      ],
    ),
  );
}
