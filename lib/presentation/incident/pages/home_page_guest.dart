import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/shimmer_widget.dart';
import 'package:inspector/presentation/incident/widget/image_slider.dart';
import 'package:inspector/presentation/incident/widget/notification_icon_widget.dart';
import 'package:inspector/presentation/incident/widget/select_incident_type_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
@RoutePage()
class HomePageGuest extends StatefulWidget {
  const HomePageGuest({super.key});

  @override
  State<HomePageGuest> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageGuest> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 90,),

            Stack(
              clipBehavior: Clip.none ,
              children: [


                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFe6eaea)
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(//HomeRouteGuest
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('hello'.tr(),
                            style: TextStyle(

                            ),),
                            const SizedBox(height: 5,),
                           Text('anonymous'.tr(),style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w700,
                             color: Color(0xFFB1B1B1)
                           ),),
                          ],
                        ),
                        Spacer(),

                        NotificationIconWidget(),


                      ],
                    ),
                  ),
                ),

                Positioned(
                    top: -0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width-40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x59808080),
                            offset: const Offset(0, 4.59),
                            blurRadius: 12,
                            spreadRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12), // optional, for rounded corners
                      ),
                      child: Row(
                        children: [

                          Text('create_your_account'.tr(),style: TextStyle(color: Color(0xFF294266),fontSize: 18,fontWeight: FontWeight.w400),),

                          const Spacer(),
                          SizedBox(
                            width: 92,
                            height: 39,
                            child: PrimaryButton(onPressed: (){
                              context.router.pushAndPopUntil(
                                const SelectModeRoute(),
                                predicate: (route) => false,
                              );
                            },
                                color: AppColors.secondaryColor,
                                child: Text('register_now'.tr(),style: TextStyle(color: Colors.white,
                                  fontSize: 12
                                ),)),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24,),

            ImageSliderWidget(),

            const SizedBox(height: 24,),
            Row(
              children: [
                Expanded(child: Material(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: (){

                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: false,
                        builder: (context) => const SelectIncidentTypeBottomSheet(),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child:  SizedBox(
                      height: 194,
                      child: Stack(
                        children: [

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFFe6eaea),

                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            padding: const EdgeInsets.only(top: 20,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('report_a_new_incident'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize:  context.locale.languageCode=='ar'? 20:18
                                    ),),
                                ),

                                const Spacer(),

                                Assets.icons.homeButtonImage2Png.image(
                                  //fit: BoxFit.contain
                                    height: 100
                                ),
                              ],
                            ),
                          ),
                          Positioned.fill(child: Assets.images.backgroundLogo.image(
                              fit: BoxFit.cover,
                              color: const Color(0xffc6c6c6)
                          )),

                        ],
                      ),


                    ),
                  ),
                )),
                const SizedBox(width: 24,),

                Expanded(child:InkWell(
                  onTap: (){},
                  splashColor: AppColors.primaryColor.withOpacity(0.25),
                  highlightColor: AppColors.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 194,
                    child: Stack(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color(0xFFe6eaea),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.only(top: 22),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text('follow_up_on_current_reports'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                    fontSize:  context.locale.languageCode=='ar'? 19:17
                                ),),
                              ),


                              const Spacer(),
                              Assets.icons.homeButtonImage1.image(
                                fit: BoxFit.fitHeight,
                                  height: 79
                              ),
                            ],
                          ),
                        ),

                        Positioned.fill(child: Assets.images.backgroundLogo.image(
                            fit: BoxFit.cover,
                          color: const Color(0xff838383)
                        )),
                      ],
                    ),
                  ),
                )),
              ],
            ),

            const SizedBox(height: 24,),


            Row(
              children: [

                Expanded(child: CardButton(title: 'recall_list'.tr(),

                  icon: Assets.icons.documentText.image(
                      width: 20,
                    fit: BoxFit.contain
                  ),
                  onTap: (){

                },)),
                const SizedBox(width: 24,),
                Expanded(child: CardButton(title: 'awareness_campaigns'.tr(),
                  icon: Assets.icons.presentionChart.image(
                    width: 20,
                  ),
                  onTap: (){},)),
              ],
            )

          ],
        ),
      ),
    );
    // return Scaffold(
    //
    //
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const SizedBox(height: 60,),
    //
    //         SizedBox(
    //          // textDirection: ui.TextDirection.ltr,
    //           child: Stack(
    //             children: [
    //
    //
    //               Container(
    //                 decoration:  BoxDecoration(
    //                   color: AppColors.secondaryColor,
    //                   borderRadius: BorderRadius.circular(24)
    //                 ),
    //                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
    //                 child: Column(
    //                   children: [
    //
    //                     Row(
    //                       children: [
    //                         Container(
    //                           height: 80,
    //
    //                           decoration: BoxDecoration(
    //                               color: Colors.white,
    //                               borderRadius: BorderRadius.circular(20)
    //                           ),
    //                           padding: EdgeInsets.all(10),
    //                           child: Assets.icons.blackLogo.image(
    //                               width: 44,
    //                               height: 60
    //                           ),
    //                         ),
    //                         const SizedBox(width: 10,),
    //                         Expanded(
    //                           child: Container(
    //                             height: 80,
    //                             decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.circular(20)
    //                             ),
    //                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    //
    //                             child: Row(
    //                               children: [
    //
    //                                 NotificationIconWidget(),
    //
    //
    //                                 Spacer(),
    //                                 Column(
    //                                   crossAxisAlignment: CrossAxisAlignment.end,
    //                                   children: [
    //                                     const Text('ترحيب بالمستخدم',
    //                                       style: TextStyle(fontSize: 16,
    //                                           fontWeight: FontWeight.w500,
    //                                           color: AppColors.primaryColor),),
    //
    //                                     const SizedBox(height: 10,),
    //
    //                                     Container(
    //                                       decoration: BoxDecoration(
    //                                           color: const Color(0xFF1FC16B),
    //                                           borderRadius: BorderRadius.circular(15)
    //                                       ),
    //                                       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
    //
    //                                       child: Text('عام',
    //                                         style: TextStyle(
    //                                             color: Colors.white
    //                                         ),),
    //                                     ),
    //
    //
    //
    //                                   ],
    //                                 ),
    //                                 const SizedBox(width: 13,),
    //
    //                                 const CircleAvatar(radius: 30,),
    //                               ],
    //                             ),
    //                           ),
    //
    //
    //                         ),
    //
    //                       ],
    //                     ),
    //
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text('البلاغات الحالية',
    //                           style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
    //
    //                         TextButton(onPressed: (){
    //                           context.router.navigate(const HistoryRoute());
    //                         }, child: Text('عرض الكل',
    //                           style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),)),
    //
    //
    //                       ],
    //                     ),
    //
    //
    //
    //                     Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: List.generate(2, (index) {
    //                         return Padding(
    //                           padding:  EdgeInsets.only(bottom: index==0 ?15:0),
    //                           child: SimpleReportWidget(report:Incident(id: 'id', userId: 'userId', description: 'description', location: 'location', incidentTypeId: 'incidentTypeId', categoryId: 'categoryId', createdAt: DateTime.now(), updatedAt: DateTime.now(), tenantId: 'tenantId',files: [])
    //                           ),
    //                         );
    //                       }),
    //                     ),
    //
    //
    //
    //                   ],
    //                 ),
    //
    //               ),
    //
    //               Positioned.fill(child: Assets.images.backgroundLogo.image(
    //                   fit: BoxFit.cover
    //               )),
    //             ],
    //           ),
    //         ),
    //
    //
    //
    //         const SizedBox(height: 20,),
    //
    //         Text(' إبلاغ عن عطل, الإبلاغ عن سرقة كهرباء',
    //           style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
    //
    //         const SizedBox(height: 10,),
    //
    //        Row(
    //          children: [
    //            Expanded(
    //                child: InkWell(
    //                  onTap: (){
    //
    //
    //                    context.router.push( LocationRoute(
    //                        incidentTypeStatic: IncidentTypeStatic.powerOutage
    //                    ));
    //                  },
    //                  borderRadius: BorderRadius.circular(8),
    //                  child: Container(
    //                      height: 185,
    //                      padding: const EdgeInsets.all(20),
    //                    decoration: BoxDecoration(
    //                        borderRadius: BorderRadius.circular(8),
    //                        border: Border.all(
    //                          color: const Color(0xFFb2b2b2),
    //                          width: 1,
    //
    //                        )
    //                    ),
    //                    child: Column(
    //                      mainAxisAlignment: MainAxisAlignment.center,
    //                      children: [
    //                        Assets.icons.menualReport.image(
    //                            width: 80,
    //                            height: 80
    //                        ),
    //                        const SizedBox(height: 7,),
    //                        Text(' إبلاغ عن عطل',
    //                          style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
    //
    //                      ],
    //                    )
    //                ),
    //              ),
    //            ),
    //            const SizedBox(width: 24,),
    //            Expanded(
    //              child:  InkWell(
    //                onTap: (){
    //                  context.router.push( LocationRoute(
    //                    incidentTypeStatic: IncidentTypeStatic.electricityTheft
    //                  ));
    //                },
    //                borderRadius: BorderRadius.circular(8),
    //                child: Container(
    //                  height: 185,
    //                  padding: const EdgeInsets.all(20),
    //                  decoration: BoxDecoration(
    //                      borderRadius: BorderRadius.circular(8),
    //                      border: Border.all(
    //                        color: const Color(0xFFb2b2b2),
    //                        width: 1,
    //
    //                      )
    //                  ),
    //                  child: Column(
    //                    children: [
    //                      Assets.icons.aiReport.image(
    //                          width: 80,
    //                          height: 80
    //                      ),
    //                      const SizedBox(height: 7,),
    //                      Text('الإبلاغ عن سرقة كهرباء',
    //                        textAlign: TextAlign.center,
    //                        style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
    //
    //                    ],
    //                  )
    //                ),
    //              ),
    //            ),
    //          ],
    //        ),
    //
    //         const SizedBox(height: 20,),
    //
    //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text('احدث حملات التوعية',
    //               style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
    //             TextButton(onPressed: (){
    //             }, child: Text('عرض الكل',
    //               style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w700),)),
    //
    //
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }


}

class CardButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget? icon;
  const CardButton({
    required this.title,
    required this.onTap,
    this.icon,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        decoration: BoxDecoration(

          border: Border.all(
            width: 1,
            color: const Color(0xFFe6eaea),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if(icon!=null) SizedBox(child: icon),
            const SizedBox(width: 10,),
            Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17

              ),)
          ],
        ),
      ),
    );
  }
}
