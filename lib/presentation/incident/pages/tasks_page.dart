import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/domain/incident/entities/visites.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:inspector/presentation/incident/pages/facilities_page.dart';
import 'package:inspector/presentation/incident/pages/home_page.dart';
import 'package:inspector/presentation/incident/pages/location_page.dart';
import 'package:inspector/presentation/incident/pages/report_visit_page.dart';
import 'package:inspector/presentation/incident/widget/notification_icon_widget.dart';

@RoutePage()
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  CustomTabListController controller=CustomTabListController();

  int selectedFilter=0;
  String? oldValue;

  bool  mapPage=false;

  @override
  Widget build(BuildContext context) {



    return ValueListenableBuilder<String?>(
        valueListenable: selectedType,

        builder: (context, value, _) {
          print("ValueListenableBuilder rebuilt! Current value: $value");


          if (oldValue != value) {
            selectedFilter=0;
            print("Value changed from $oldValue to $value");
          } else {
            print("Builder rebuilt without value change (likely setState)");
          }
          oldValue = value;

          List<Facility> list =context.locale.languageCode=='ar'?facilities:facilitiesEn ;

          List<String> filters =context.locale.languageCode=='ar'?  visits.map((e)=>e.visitType).toSet().toList():visitsEn.map((e)=>e.visitType).toSet().toList();

          // Keep the selected tab index within range of the (data-driven) tabs.
          if (selectedFilter >= filters.length) selectedFilter = 0;

          List<Facility> filteredList=filters.isEmpty
              ? const <Facility>[]
              : list.where((e)=>e.type==filters[selectedFilter]).toList();

          if(selectedType.value!=null){
            filteredList =filteredList.where((e)=>e.status==selectedType.value).toList();
          }

        return Scaffold(
          extendBody: false,
          extendBodyBehindAppBar: true,


          // appBar: AppBarWidget(titleWidget:  Text('المنشأت',
          //   style: const TextStyle(
          //       fontWeight: FontWeight.w500,
          //       fontSize: 24
          //   ),),
          //   forceShowBackButton: true,
          //   onBackButtonClicked: (){
          //     context.router.navigate(const HomeRoute());
          //
          //   },
          // ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                const SizedBox(height: 85,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform:context.locale.languageCode =='ar'? (Matrix4.identity()..scale(-1.0, 1.0)): Matrix4.identity()..scale(1.0, 1.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,

                        ),
                        child: Assets.icons.arrow.image(),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('hello'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18
                          ),),
                        const SizedBox(height: 5,),
                         SizedBox(
                           width: MediaQuery.of(context).size.width*0.5  ,

                           child: Text("sami_bin_abdullah_al_qahtani".tr(),
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),),
                         ),
                        const SizedBox(height: 5,),

                        Text('June 06, 2024'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Poppins'
                          ),),

                      ],
                    ),
                    Spacer(),

                    NotificationIconWidget(),
                    const SizedBox(width: 10,),

                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 5),
                      child: InkWell(
                          child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: const Color(0xFFF9F9F9)
                              ),

                              child: Center(child: Assets.icons.refresh.image(width: 20),
                              ))),
                    ),


                  ],
                ),
                const SizedBox(height: 24,),


                Builder(
                  builder: (context) {

                 //   var list  =['الكل','زيارة الشكوى','زيارة ترخيص وتصنيف','زيارة'];




                    Container(
                      height: 58,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x1A000000), // same as #0000001A
                            offset: const Offset(0, 0),     // x: 0px, y: 0px
                            blurRadius: 8,                  // blur
                            spreadRadius: -12,              // spread (-12)
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),


                      child:CustomTabList(
                        controller:  controller,
                        tabs:filters,
                        onChange: (){

                          setState(() {

                          });
                        },
                      ),);



                    // Group filters into sets of 2
                    final List<List<String>> groupedFilters = [];
                    for (int i = 0; i < filters.length; i += 2) {
                      groupedFilters.add(
                        filters.sublist(i, (i + 2 > filters.length) ? filters.length : i + 2),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = constraints.maxWidth;

                        return SizedBox(
                          height: 44,

                          child: CarouselSlider.builder(

                            itemCount: groupedFilters.length,

                            itemBuilder: (context, index, realIndex) {
                              final pair = groupedFilters[index];
                              final isLast = index == groupedFilters.length - 1;

                              // if last item has only 1 filter, make it smaller
                              final itemWidth = isLast && pair.length == 1
                                  ? screenWidth / 2 // half width for one item
                                  : screenWidth; // full width for pairs

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  SizedBox(
                                    width: itemWidth,

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        for (int i = 0; i < pair.length; i++) ...[
                                          Expanded(
                                            child: FilterWidget(
                                              title: pair[i],
                                              onTap: () {
                                                final globalIndex = index * 2 + i;
                                                setState(() => selectedFilter = globalIndex);
                                              },
                                              isSelected: selectedFilter == index * 2 + i,
                                            ),
                                          ),
                                          if (i == 0 && pair.length > 1)
                                            const SizedBox(width: 8),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            options: CarouselOptions(
                              height: 44,
                              enableInfiniteScroll: false,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              padEnds: false,
                            ),
                          ),
                        );
                      },
                    );
                    return SizedBox(
                      height: 44,
                      child: ListView.separated(
                          itemCount: filters.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return  FilterWidget(title: filters[index], onTap: (){

                              selectedFilter=index;
                              setState(() {

                              });
                            },isSelected: selectedFilter==index,);
                      },

                      separatorBuilder: (context,index){
                            return  const SizedBox(width: 8,);
                      },
                      ),
                    );
                  }
                ),

                const SizedBox(height:10 ,),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: (){
                        context.router.navigate(const HomeRoute());
                      },
                      child: Row(
                        children: [
                          Material(
                            elevation: 0.5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Assets.icons.homeIcon.image()),
                          ),
                          const SizedBox(width: 8,),
                          Text('home'.tr())
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        mapPage=false;
                        setState(() {});
                      },
                      child: Material(
                        elevation: 0.5,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Assets.icons.menu.image()),
                      ),
                    ),
                    const SizedBox(width: 8,),

                    GestureDetector(
                      onTap: (){
                        mapPage=true;
                        setState(() {});
                      },
                      child: Material(
                        elevation: 0.5,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Assets.icons.map.image()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:10 ,),


                if(mapPage)  const Expanded(
                  child: LocationPage(
                    isWidget: true, incidentTypeStatic: IncidentTypeStatic.ai,
                  ),
                )else
                Expanded(
                  child: ListView.separated(
                      itemCount: filteredList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      itemBuilder: (context,index){
                        return IncidentWidget(facility: filteredList[index],);
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(height: 10,);
                      }),
                ),




                // //  FilterWidget
                // const SizedBox(height: 10,),

              ],
            ),
          ),
        );
      }
    );
  }
}

class IncidentWidget extends StatelessWidget {
  final Facility facility;
  const IncidentWidget({
    required this.facility,
    super.key});

  @override
  Widget build(BuildContext context) {


    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 0.2,
      child: InkWell(

        borderRadius: BorderRadius.circular(24),

        onTap: (){
         context.router.push(StartVisitRoute());

        },
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
                    padding: EdgeInsets.symmetric(horizontal: 7,vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0xFFf9f9f9),
                        borderRadius: BorderRadius.circular(44),
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
                  )
                ],
              ),
              const SizedBox(height: 10,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 2),
                  //   child: Icon(
                  //     Icons.location_on,
                  //     size: 22,
                  //     color: Color(0xFFB1B1B1),
                  //   ),
                  // ),
                  // const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          facility.report?.description??'',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Text(
                        //   '${facility.distance.toString()??''} KM',
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //     fontWeight: FontWeight.w400,
                        //     fontSize: 13,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  
                  Material(
                    clipBehavior: Clip.hardEdge,
                    color:AppColors.secondaryColor ,
                    elevation: 0.3,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: (){
                        
                      },
                      borderRadius: BorderRadius.circular(20),

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                          child: Text(facility.status.tr(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12
                            ),),
                        ),
                      ),
                    ),
                  )

                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(

                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const  Color(0xFFf9f3ff),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Assets.icons.calendarIcon.image(
                                  color: const Color(0xFF9810FA)
                              ),
                              Text('date'.tr(),
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: const Color(0xFF9a6eba)
                                ),),
                              const Spacer(),
                          
                            ],
                          ),
                          const SizedBox(height: 3,),
                          Text('23-08-2024',
                          style: TextStyle(
                            color: Color(0xFF59168B)
                          ),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),


                  Expanded(
                    child: Container(

                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Assets.icons.clock.image(
                                  color: const Color(0xFF155DFC)
                              ),
                              Text('time'.tr(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF6f84bb)
                                ),),
                              const Spacer(),

                            ],
                          ),

                          const SizedBox(height: 3,),
                          Text('2:00_pm'.tr(),
                            style: TextStyle(
                                color: Color(0xFF1c398d)
                            ),)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                          color: Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Assets.icons.locationIcons.image(
                                  color: const Color(0xFF009966),
                                width: 18
                              ),
                              Text('distance'.tr(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: const Color(0xFF5c9483)
                                ),),
                              const Spacer(),

                            ],
                          ),//234 كم
                          const SizedBox(height: 3,),
                          Text('234_km'.tr(),
                            style: TextStyle(
                                color: Color(0xFF004F3B)
                            ),)
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

class FilterWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;
  final double elevation;
  final Color? color;

  const FilterWidget({
    required this.title,
    required this.onTap,
    this.isSelected=false,
    this.elevation=0.3,
    this.color,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      clipBehavior: Clip.hardEdge,
      color:color?? (isSelected? AppColors.primaryColor: Colors.white) ,
      elevation: 0.1,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: (){
          onTap();
        },
        borderRadius: BorderRadius.circular(20),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
            child: Text(title,
            style: TextStyle(
              color: isSelected ?Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15

            ),),
          ),
        ),
      ),
    );
  }
}


