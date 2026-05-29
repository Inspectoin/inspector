import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/incident/pages/facilities_page.dart';
import 'package:inspector/presentation/incident/widget/create_visit_bottom_sheet.dart';

@RoutePage()
class CreateVisitPage extends StatefulWidget {
  const CreateVisitPage({super.key});

  @override
  State<CreateVisitPage> createState() => _CreateVisitPageState();
}

class _CreateVisitPageState extends State<CreateVisitPage> {
  bool isFacilitySelected=false;
  bool isVisitTypeSelected=false;
  int selectedIndex=-1;

  @override
  Widget build(BuildContext context) {

    var list =context.locale.languageCode=='ar'?facilities:facilitiesEn ;

    return  Scaffold(
      appBar: AppBarWidget(titleWidget:  Text('create_visit'.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [


            Expanded(
              child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context,index){
                    return FacilityWidget(facility: list[index],
                      isSelected: selectedIndex==index,
                      onTap:null,
                    );
                  },
                  separatorBuilder: (context,index){
                    return const SizedBox(height: 10,);
                  }),
            ),

            // Expanded(
            //   child: Container(
            //     padding: EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //         border: Border.all(
            //           width: 1,
            //           color: Color(0xFFe0e4e4)
            //         )
            //
            //     ),
            //     child:  ListView.separated(
            //         itemCount: list.length,
            //         itemBuilder: (context,index){
            //
            //
            //           return VisitWidget(facility: list[index],);
            //         },
            //         separatorBuilder: (context,index){
            //           return const SizedBox(height: 10,);
            //         }),
            //   ),
            // ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 360,
              child: Row(
                children: [
                  Column(
                    children: [

                      Opacity(
                        opacity: (!isFacilitySelected )? 0.3:1,
                  child: Material(

                              clipBehavior: Clip.antiAlias,
                  color: const Color(0xFFe6fbf2),
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(20), // 👈 Rounded corners
                  ),

                  elevation: 0.5,

                  child: InkWell(
                    onTap:!isFacilitySelected? null: (){
                      context.router.push(const SelectVisitTypeRoute()).then((e){
                        setState(() {
                          isVisitTypeSelected=true;
                        });
                      });

                    },
                    child: Container(
                      width: 150,
                      height: 300,


                      child: Stack(
                        children: [

                          Positioned.fill(child: Assets.images.cardPattren.image(
                              fit: BoxFit.fitHeight
                          )),

                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Container(
                              width: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Assets.icons.search.image(
                                  color: AppColors.primaryColor,
                                      width: 24
                                  ),
                                ),
                              ),
                            ),
                                const SizedBox(height: 5,),
                                Text(
                                  'visit_type'.tr(),
                                  style:  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.primary2Color
                                  ),
                                ),
                                if(!isVisitTypeSelected)
                                const SizedBox(height: 5,),
                                if(!isVisitTypeSelected)
                                Text(
                                  'please_select_visit_type'.tr(),
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xFF5b9482)
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                if(isVisitTypeSelected)
                                Material(

                                  color:Colors.white,
                                  elevation: 0.4,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: Text('inspection_type_complaint_inspection'.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                              ),
                ),
                      const SizedBox(height: 20,),

                      Opacity(
                        opacity:(isVisitTypeSelected && isFacilitySelected)? 1:0.5,
                        child: SizedBox(
                          width: 150,
                          child: PrimaryButton(
                            onPressed:(isVisitTypeSelected && isFacilitySelected)?  (){



                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: false,
                                builder: (context) => const CreateVisitBottomSheet(
                                  visitDone: false,
                                ),
                              );

                            } :null,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                Assets.icons.addSquare.image(
                                    color: Colors.white,
                                    width: 24
                                ),
                                const SizedBox(width: 10,),

                                Text('create_visit'.tr(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,

                                  ),),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    children: [

                      Material(

                        clipBehavior: Clip.antiAlias,
                        color: Color(0xFFe8e2ee),
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(20), // 👈 Rounded corners
                        ),

                        //  borderRadius: BorderRadius.circular(20),
                        elevation: 0.5,

                        child: InkWell(
                          onTap: (){
                            context.router.push(FacilitiesRoute(
                                type: FacilitiesPageType.selectOneFacility
                            )).then((e){

                              isFacilitySelected=true;
                              setState(() {

                              });
                            });
                          },
                          child: Container(
                            height: 126,
                            width: MediaQuery.of(context).size.width-210,

                            child: Stack(
                              children: [

                                Positioned.fill(child: Assets.images.cardPattren.image(
                                    fit: BoxFit.fitWidth,
                                  color: Color(0xFFe0dbe6),

                                )),

                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Assets.icons.building.image(
                                                color:Color(0xFF9810FA),
                                                width: 24
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(
                                        'facility'.tr(),
                                        style:  TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color:Color(0xFF59168B)
                                        ),
                                      ),

                                      if(!isFacilitySelected)
                                      const SizedBox(height: 5,),
                                      if(!isFacilitySelected)
                                        Text(
                                        'please_select_a_facility'.tr(),
                                        style:  TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Color(0xFF9268b3)
                                        ),
                                      ),



                                      if(isFacilitySelected)
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text('facility_al_nakheel_hotel'.tr(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 8,
                                              color: AppColors.primary2Color
                                            ),),
                                          const SizedBox(width: 5,),

                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Color(0xFFf9f9f9),
                                                borderRadius: BorderRadius.circular(44),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xffd6d5d5)
                                                )
                                            ),
                                            child:  Center(
                                              child: Text('LS00000112',
                                                style: TextStyle(
                                                    color: AppColors.primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 8
                                                ),),
                                            ),
                                          ),

                                        ],
                                      ),


                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),

                      Opacity(
                        opacity: (isFacilitySelected || isVisitTypeSelected )? 0.1:1,
                        child: Material(

                          clipBehavior: Clip.antiAlias,
                          color:AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(20), // 👈 Rounded corners
                          ),

                          //  borderRadius: BorderRadius.circular(20),
                          elevation: 0.5,

                          child: InkWell(
                            onTap:(isFacilitySelected || isVisitTypeSelected )? null:(){



                              Navigator.of(context).pop();

                              context.router.push(InspectionPlanRoute());
                            },
                            child: Container(
                              height: 214,
                              width: MediaQuery.of(context).size.width-210,

                              child: Stack(
                                children: [

                                  Positioned.fill(child: Assets.images.cardPattren.image(
                                    fit: BoxFit.fitWidth,
                                    color: Color(0xFFe0dbe6),

                                  )),

                                  Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,

                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: Assets.icons.documentFavorite.image(
                                                  color: AppColors.primary2Color,
                                                  width: 24
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          'inspection_plan_optional'.tr(),
                                          style:  TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.white
                                          ),
                                        ),

                                        const SizedBox(height: 5,),
                                        Text(
                                          'please_select_the_inspection_plan'.tr(),
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.primaryColor
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])

                ],
              ),
            ),

            const SizedBox(height: 33,)

          ],
        ),
      ),

    );
  }
}


class VisitWidget extends StatelessWidget {
  final Facility facility;
  const VisitWidget({
    required this.facility,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        elevation: 0.2,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
          child: Row(

            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Expanded(
                            child: Text(facility.name,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                overflow:TextOverflow.ellipsis,
                                fontSize: 18,
                              ),),
                          ),



                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(
                                color: Color(0xFFf9f9f9),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 1,
                                    color: Color(0xffd6d5d5)
                                )
                            ),
                            child:  Center(
                              child: Text('${facility.licenseNumber}',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                ),),
                            ),
                          ),

                        ],
                      ),


                      const SizedBox(height: 10,),
                      Row(
                        children: [

                          Flexible(
                            child: Text('periodic_inspection'.tr(),
                            style: TextStyle(
                              fontSize: 12
                            ),),
                          ),
                          Expanded(
                            child: Container(
                              width: 68,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: const  Color(0xFFf9f3ff),
                                  borderRadius: BorderRadius.circular(11)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.icons.calendarIcon.image(
                                          color: const Color(0xFF9810FA),
                                        width: 10
                                      ),
                                      Text('date'.tr(),
                                        style: const TextStyle(
                                            fontSize: 8,
                                            color: const Color(0xFF9a6eba)
                                        ),),

                                    ],
                                  ),
                                  const SizedBox(height: 3,),
                                  Text('23-08-2024',
                                    style: TextStyle(
                                        color: Color(0xFF59168B),
                                      fontSize: 8
                                    ),)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 2,),


                          Expanded(
                            child: Container(
                              width: 68,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(11)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.icons.clock.image(
                                          color: const Color(0xFF155DFC),
                                        width: 10
                                      ),
                                      Text('time'.tr(),
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Color(0xFF6f84bb)
                                        ),),

                                    ],
                                  ),

                                  const SizedBox(height: 3,),
                                  Text('2_00_pm'.tr(),
                                    style: TextStyle(
                                        color: Color(0xFF1c398d),
                                      fontSize: 8,
                                    ),)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 2,),
                          Expanded(
                            child: Container(
                              width: 68,
                              padding: const EdgeInsets.all(2),

                              decoration: BoxDecoration(
                                  color: Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(11)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.icons.locationIcons.image(
                                          color: const Color(0xFF009966),
                                          width: 10
                                      ),
                                      Text('distance'.tr(),
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: const Color(0xFF5c9483)
                                        ),),

                                    ],
                                  ),//234 كم
                                  const SizedBox(height: 3,),
                                  Text('234_km'.tr(),
                                    style: TextStyle(
                                        color: Color(0xFF004F3B),
                                      fontSize: 8
                                    ),)
                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                        //



                                        ]),
                ),
              ),

        SizedBox(

          width: 50,
          height: 125,
          child: Material(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(24),
              bottomEnd: Radius.circular(24),

            ),
            elevation: 0.2,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Assets.icons.addSquare.image(
                  width: 24
                ),
                const SizedBox(height: 5,),

                Text('edit_visit'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                ),)


          ]),),
        )

            ],
          ),
        ),
      ),
    );
  }
}
