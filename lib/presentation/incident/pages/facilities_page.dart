

import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/presentation/incident/widget/reports.dart';


enum FacilitiesPageType{forPlans,selectOneFacility,list}
@RoutePage()
class FacilitiesPage extends StatefulWidget {
  final FacilitiesPageType type;
  const FacilitiesPage({
    this.type=FacilitiesPageType.list,
    super.key});

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> with ScreenUtils,AutomaticKeepAliveClientMixin{
  int selectedIndex=-1;

  @override
  Widget build(BuildContext context) {
    var list =context.locale.languageCode=='ar'?facilities:facilitiesEn ;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(
        titleWidget:  Text('facilities'.tr()),
        subTitleWidget:widget.type !=FacilitiesPageType.list?  Text('please_select_a_facility'.tr(),
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.grayTextColor,
          fontWeight: FontWeight.w400
        ),):null,
        forceShowBackButton: true,
        onBackButtonClicked: (){
          if(widget.type==FacilitiesPageType.list) {
            context.router.navigate(const HomeRoute());
          }else {
            Navigator.of(context).pop();

          }

        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [


        Container(
        width: MediaQuery.sizeOf(context).width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: InkWell(
                onTap: () {
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Assets.icons.search.image(
                      width: 21,
                      height: 21,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Simple TextField
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  filled: true,
                  fillColor: const Color(0xFFF9F9F9),
                  hintText: 'search'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  print('Location typed: $value');
                },
              ),
            ),
            const SizedBox(width: 10),

            InkWell(
              onTap: (){
                context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.ai));
              },
              child: Container(
                padding: const EdgeInsets.all(10),

                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.secondaryColor
                ),
                child:  Center(
                  child: Assets.icons.location.image(
                      width: 21,
                      height: 21
                  ),
                ),
              ),
            ),
          ],
        ),
      ),



            const SizedBox(height: 10,),
            Expanded(
              child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context,index){
                    return FacilityWidget(facility: list[index],
                    isSelected: selectedIndex==index,
                      onTap:widget.type==FacilitiesPageType.list? null: (){
                      selectedIndex=index;
                      setState(() {

                      });
                      },
                    );
                  },
                  separatorBuilder: (context,index){
                    return const SizedBox(height: 10,);
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: widget.type !=FacilitiesPageType.selectOneFacility?null:FloatingActionButton(onPressed: (){
        context.router.push(AddFacilityRoute());
      },
      child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: AppColors.primaryColor,
      shape: CircleBorder(

      ),
      ) ,
      bottomNavigationBar:widget.type ==FacilitiesPageType.list?null: Container(
        height: 90,
        child:  Column(

          children: [

            const SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){


                  if(selectedIndex==-1){
                    showError(customMessage: 'please_select_a_facility'.tr());
                    return;
                  }

                  if(widget.type==FacilitiesPageType.selectOneFacility){
                    Navigator.of(context).pop();
                  }else if(widget.type==FacilitiesPageType.forPlans){
                    int count = 0;
                    context.router.popUntil((_) => count++ >= 2);


                    context.router.push(StartVisitRoute());
                  }





                },
                child: Wrap(
                  children: [
                    Assets.icons.addSquare.image(
                        color: Colors.white,
                        width: 24
                    ),
                    const SizedBox(width: 10,),

                    Text('select_facility'.tr(),
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

  @override
  bool get wantKeepAlive => false;
}

class FacilityWidget extends StatelessWidget {
  final Facility facility;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const FacilityWidget({
    required this.facility,
    this.isSelected=false,
    this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected? AppColors.primaryColor.withOpacity(0.3) :Colors.white,
      borderRadius: BorderRadius.circular(24),
elevation: 0.2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child:  Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(facility.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        overflow:TextOverflow.ellipsis,
                        fontSize: 18,
                      ),),
                  ),



                  const SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFFf9f9f9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1,
                            color: Color(0xffd6d5d5)
                        )
                    ),
                    child:  Center(
                      child: Text('license_number'.tr() +': ${facility.licenseNumber}',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                        ),),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.location_on,
                      size: 22,
                      color: Color(0xFFB1B1B1),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          facility.location,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${facility.distance.toString()??''} KM',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,

                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color(0xFFe7fdf2),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Assets.icons.profileOutlined.image(
                              color: const Color(0xFF009966)
                          ),
                          Spacer(),
                          SizedBox(
                            width: 80,
                            child: Text(facility.contactInfo.contactPerson,
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11,
                                  color: AppColors.secondaryColor
                              ),),
                          ),
                          const Spacer(),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      height: 30,

                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color(0xFFf9f3ff),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Row(
                        children: [
                          Assets.icons.call.image(
                              color: const Color(0xFF9810FA)
                          ),
                          const Spacer(),
                          Text(facility.contactInfo.phone,
                            style: TextStyle(
                              fontSize: 11,
                                color: const Color(0xFF9810FA)
                            ),),
                          const Spacer(),

                        ],
                      ),
                    ),
                  ),

                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}


class Facility {
  final String id;
  final String name;
  final String type;
  final String location;
  final String licenseNumber;
  final String status;
  final String color;
  final ContactInfo contactInfo;
  final String lastUpdate;
  final double distance;
  final Report? report;

  Facility({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.licenseNumber,
    required this.status,
    required this.color,
    required this.contactInfo,
    required this.lastUpdate,
    required this.distance,
    this.report,
  });
}

class ContactInfo {
  final String phone;
  final String contactPerson;

  ContactInfo({required this.phone, required this.contactPerson});
}


// Populated at app start-up from assets/json/mewa_mock_data.json
// (see MewaMockData.load). Arabic + English reuse the same MEWA content.
List<Facility> facilities = <Facility>[];
List<Facility> facilitiesEn = <Facility>[];
