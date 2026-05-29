import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/domain/incident/entities/questions.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/incident/pages/report_visit_page.dart';
import 'package:inspector/presentation/incident/pages/start_visit_page.dart';
import 'package:inspector/presentation/incident/widget/steps_progress_widget.dart';
import 'package:inspector/presentation/incident/widget/upload_file_bottom_sheet.dart';

@RoutePage()
class ReviewReportVisitPage extends StatefulWidget {
  const ReviewReportVisitPage({super.key});

  @override
  State<ReviewReportVisitPage> createState() => _ReviewReportVisitPageState();
}

class _ReviewReportVisitPageState extends State<ReviewReportVisitPage> {

  int selectedOption = 0;

  final options = ["matching".tr(), "not_matching".tr(), "needs_improvement".tr()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBarWidget(titleWidget: Text('visit_report_vs00010039'.tr()),color: Colors.white,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 23,),
            Text('review_visit'.tr(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),),
            const SizedBox(height: 23,),

            // Step Progress
             StepsProgressWidget(
              currentStep: 2,
              visitNumber: 'LS00010039',
            ),            const SizedBox(height: 20),

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
                        "al_nakheel_hotel".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFe9faf0),

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "in_progress".tr(),
                          style: TextStyle(
                            color: Color(0xFF009966),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 10),
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
                          "water_leak_report_in_room_308".tr(),
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
                      value: "2_00_pm".tr(),
                      icon: Icons.access_time,
                      color: const Color(0xFFE9F1FF),
                      contentColor: const  Color(0xFF5487cd)
                  ),
                  const SizedBox(height: 8),
                  infoRow(
                      label: "distance".tr(),
                      value: "234_km".tr(),
                      icon: Icons.location_on_outlined,
                      color: const Color(0xFFe6fcf1),
                      contentColor: Color(0xFF7fad9e)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('inspection_lists_results'.tr(),
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,),),
                ),


                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFFfaeee4),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        children: [
                          Text('200',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFFFF8D28)),),
                          Text('sar_fine'.tr(),
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 11,color: Color(0xFFFF8D28)),),

                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                      decoration: BoxDecoration(
                          color: Color(0xFFff6e4e4),

                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Text('4',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFFFF383C)),),
                          Text('violation'.tr(),
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 11,color: Color(0xFFFF383C)),),

                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                      decoration: BoxDecoration(
                          color: Color(0xFFe5f4e9),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Text('60%',
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFF34C759)),),
                          Text('compliance'.tr(),
                            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 11,color: Color(0xFF34C759)),),

                        ],
                      ),
                    ),
                  ],
                ),



              ],
            ),

            const SizedBox(height: 24),


            CustomExpansionTile(
              isViolation: true,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      '1. ${'are_corridors_cleaned_regularly'.tr()}',
                      maxLines: 3,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              children: [
                _buildReviewCard(isViolation: true)
              ],
            ),
            const SizedBox(height: 20),

            CustomExpansionTile(
              isViolation: false,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      '2. ${'are_waste_bins_emptied_regularly'.tr()}',
                      maxLines: 3,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              children: [
                _buildReviewCard(isViolation: false)
              ],
            ),

            const SizedBox(height: 50),

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




                  context.router.push(const SignReportRoute());



                },
                child: Text('next'.tr() ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildReviewCard({required  bool isViolation}) {
    return Container(
     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 16,),


          if(!isViolation)...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
              decoration: BoxDecoration(
                  color:AppColors.background,

                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('matching'.tr(),
                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),

                   ],
              ),
            ),
          ]else

        //  const SizedBox(height: 16),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 12),
            decoration: BoxDecoration(
                color: Color(0xFFff6e4e4),

                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('violation'.tr(),
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Color(0xFFFF383C)),),

                // Text('4',
                //   style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Color(0xFFFF383C)),),

              ],
            ),
          ),
          const SizedBox(height: 16),


          Row(
            children: [
              InkWell(

                  child: buildFileButton(Assets.icons.camera.image(), "photos".tr(), const Color(0xFFe9faf0),
                  counter: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1FC16B)


                    ),
                    child: Center(
                      child: Text('2',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400
                      ),),
                    ),))),
              const SizedBox(width: 8),
              buildFileButton(Assets.icons.documentFavorite.image(), "documents".tr(),  const Color(0xFFe6eaea),
                  counter: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1FC16B)


                    ),
                    child: Center(
                      child: Text('2',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400
                      ),),
                    ),)),
            //  const SizedBox(width: 8,),
              // Container(
              //   width: 20,
              //   height: 20,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //       color: Color(0xFF1FC16B)
              //
              //
              //   ),
              // child: Center(
              //   child: Text('2',style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 14,
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w400
              //   ),),
              // ),)
              //
            ],
          ),

          const SizedBox(height: 12),

          const SizedBox(height: 10),

          // Padding(
          //     padding: const EdgeInsets.symmetric(
          //         vertical: 8.0),
          //     child: CustomUploadFilesWidget(
          //       enabled: false,
          //       boxColor: const Color.fromRGBO(
          //           255, 252, 255, 1),
          //       borderColor: AppColors.primaryColor,
          //       files: [],
          //       filesCubits: [],
          //       maxFilesCount: 20,
          //       onChange: (){setState(() {});},
          //       onFileUploaded: (){
          //         setState(() {});
          //       },
          //     )),
          //
          //
          // const SizedBox(height: 16),

         Container(
           padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
           decoration: BoxDecoration(
               border: Border.all(color:  Color(0xFFe6eaea),width: 1),
             borderRadius: BorderRadius.circular(10)
           
           ),
           child: Text('water_leak_report_in_room_308_reported_by_customer'.tr(),
           style: TextStyle(
             color: AppColors.grayTextColor
           ),),
         ),
          const SizedBox(height: 16),

          PrimaryButton(onPressed: (){}, child: Wrap(
            children: [
              Assets.icons.edit.image(width: 24,color: Colors.white),

              const SizedBox(width: 10 ,),
              Text('edit'.tr()),

            ],
          ))
        ],
      ),
    );
  }

}
class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final bool isViolation;
  final List<Widget> children;
  final Color? backgroundColor;
  final Duration duration;
  final Icon? leadingIcon; // optional leading icon

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.isViolation,
    required this.children,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 300),
    this.leadingIcon,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Animation<double> _reverseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _reverseAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animation);
  }


  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }

    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 22),

      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,

        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            blurRadius: 8,
            spreadRadius: -12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggleExpansion,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      if (widget.leadingIcon != null) ...[
                        widget.leadingIcon!,
                        const SizedBox(width: 8),
                      ],
                      Expanded(child: widget.title),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0.0, // 180° rotation when expanded
                        duration: widget.duration,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                  SizeTransition(
                   // key: '${Ra}',
                      sizeFactor: _reverseAnimation,
                    child:  Column(
                      children: [
                        const SizedBox(height: 16,),

                        Row(
                          children: [
                            buildFileButton(Assets.icons.camera.image(
                              width: 20
                            ), "photos".tr(), const Color(0xFFe9faf0),counter:  Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1FC16B)


                              ),
                              child: Center(
                                child: Text('2',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400
                                ),),
                              ),) ),
                            const SizedBox(width: 5),
                            buildFileButton(Assets.icons.documentFavorite.image(
                                width: 20
                            ), "documents".tr(),  const Color(0xFFe6eaea),counter:  Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF1FC16B)


                              ),
                              child: Center(
                                child: Text('2',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400
                                ),),
                              ),)),
                            const SizedBox(width: 5,),

                            if(widget.isViolation)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 9),
                              decoration: BoxDecoration(
                                  color: Color(0xFFff6e4e4),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [


                                    Text('violation'.tr(),
                                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFFFF383C)),),
                                    const SizedBox(width: 8,),




                                  // Text('4',
                                  //   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(0xFFFF383C),)),

                                ],
                              ),
                            ),
                            const SizedBox(width: 8,),


                          ],
                        ),
                      ],
                    )),

                ],
              ),
            ),
          ),

          SizeTransition(
            sizeFactor: _animation,
            child: Column(children: widget.children),
          ),
        ],
      ),
    );
  }
}


