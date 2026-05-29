
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/incident/widget/view_inspection_details_bottom_sheet.dart';

@RoutePage()
class InspectionPlanPage extends StatefulWidget {
  const InspectionPlanPage({super.key});

  @override
  State<InspectionPlanPage> createState() => _InspectionPlanPageState();
}

class _InspectionPlanPageState extends State<InspectionPlanPage> {



  @override
  Widget build(BuildContext context) {
    List<InspectionPlan> inspectionPlans=[
      InspectionPlan(title: 'خطط تفتيشيه عل المدينة المنورة', reason: 'تهدف هذه الخطة التفتيشية للتفتيش علي فنادق و نزل العاصمة المقدسة.',  location: 'العاصمة المقدسة. ', duration: 14),
      InspectionPlan(title: 'خطط تفتيشيه في جدة', reason: 'تسعى هذه الخطة التفتيشية لمراقبة جودة الخدمات المقدمة في المنتجعات السياحية.',  location: 'مدينة جدة.', duration: 30),
      InspectionPlan(title: 'خطط تفتيشيه في الرياض', reason: 'تركز هذه الخطة التفتيشية على تقييم المعايير الصحية في المطاعم والمقاهي.',  location: 'العاصمة الرياض.', duration: 7),
    ];

    return Scaffold(
      appBar: AppBarWidget(titleWidget: Text('inspection_plan'.tr())),
      body:ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20
        ),
          itemBuilder: (context,index){
            return InspectionPlanWidget(
              inspectionPlan: inspectionPlans[index],
            );
          }, separatorBuilder: (context,index){
            return const SizedBox(height:10);
    }, itemCount: inspectionPlans.length),

    
    );
  }
}

class InspectionPlan {
  String title;
  String reason;
  String location;
  int duration;


  InspectionPlan({
    required this.title,
    required this.reason,
    required this.location,
    required this.duration,
  });
}

class InspectionPlanWidget extends StatelessWidget {
  final InspectionPlan inspectionPlan;

  const InspectionPlanWidget({
    required this.inspectionPlan,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: BorderRadius.circular(24),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(inspectionPlan.title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                ),


                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: BoxDecoration(
                      color: Color(0xFFf9f9f9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Color(0xffd6d5d5)
                      )
                  ),
                  child:  Center(
                    child: Wrap(
                      children: [
                        Text('plan_duration'.tr(),
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12
                          ),),
                        const SizedBox(width: 2,),
                        Text(inspectionPlan.duration.toString(),
                          style: TextStyle(
                              color: AppColors.primary2Color,
                              fontWeight: FontWeight.w400,
                              fontSize: 12
                          ),),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 10,),
            Text('plan_reason'.tr(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),

            const SizedBox(height: 5,),
            Text(inspectionPlan.reason,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.grayTextColor
              ),),

            const SizedBox(height: 10,),
            Row(
              children: [
                Assets.icons.location.image(
                  width: 12,
                  color: AppColors.grayTextColor
                ),
                const SizedBox(width: 5,),
                Text(inspectionPlan.location,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF444444)
                  ),),
              ],
            ),
            const SizedBox(height: 10,),

            SizedBox(
              height: 37,
              child: PrimaryButton(
                  color: const Color(0xFFe6eaea),
                  onPressed: (){


                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: false,
                      builder: (context) => const ViewInspectionDetailsBottomSheet(),
                    );


              }, child:Text('click_for_more'.tr(),
              style: TextStyle(
                color: AppColors.primary2Color,

              ),)),
            )
          ],
        ),
      ),
    );
  }
}
