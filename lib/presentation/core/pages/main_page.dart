import 'package:auto_route/auto_route.dart';
import 'package:awesome_bottom_bar_custom/awesome_bottom_bar_custom.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/bottom_bar.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key,});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  TabsRouter? _tabsRouter;

  int index=0;

  double width =25;
  double height =25;

  changeIndex(int i){
    setState(() {
      index=i;
    });
  }

  GlobalKey _buttonKey = GlobalKey();
  double _buttonTop = 0.0;
  double _buttonLeft = 0.0;

  @override
  Widget build(BuildContext context) {



    /// must be in build for update language
    final List<TabItem<Widget>> items = [

      TabItem<Widget>(
        icon:index==0 ?
        Assets.icons.addSquare.image(
          width: width,
          height: height,
          color:  Colors.white,
        ): Assets.icons.addSquare.image(
          width: width,
          height: height,

        )
        ,
        title: 'create_visit'.tr(),
      ),

      TabItem<Widget>(
        icon:index==1 ?
        Assets.icons.taskSquareActive.image(
          width: width,
          height: height,
          color: AppColors.secondaryColor,

        ): Assets.icons.taskSquare.image(
            width: width,
            height: height,
          color: Colors.grey
        )
        ,
        title: 'my_tasks'.tr(),
      ),

      TabItem<Widget>(
        icon:index==2 ?
        Assets.icons.buildingActive.image(
          width: width,
          height: height,
          color: AppColors.secondaryColor,

        ): Assets.icons.building.image(
            width: width,
            height: height
        ),

        title: 'facilities'.tr(),
      ),


      TabItem<Widget>(
        icon:index==3 ?
        Assets.icons.profile.image(
            width: width,
            height: height,
          color: AppColors.secondaryColor,

        ): Assets.icons.profileOutlined.image(
          width: width,
          height: height,
            color: Colors.grey

        ),
        title: 'profile'.tr(),
      ),

    ];

    return AutoTabsScaffold(
      extendBody: false,
      routes:   [
        HomeRoute(),
        TasksRoute(),


        FacilitiesRoute(),
        ProfileRoute()
      ],


      bottomNavigationBuilder: (_, tabsRouter) {
        //  this.tabsRouter = tabsRouter;
        index= tabsRouter.activeIndex;



        /// final tabsRouter = AutoTabsRouter.of(context);

        return _TabsListenerWrapper(
          tabsRouter: tabsRouter,
          onChange: (index){
            this.index=index;
            setState(() {});
          },
          child: Container(

            padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 29.0,
                right: 16.0,
                left: 16.0
            ),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x33000000).withOpacity(0.08), // #00000033 (20% opacity black)
                    offset: const Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 1.76,
                  ),
                ],
                borderRadius: BorderRadius.circular(77),
              ),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(77),
                child: BottomBarSalomon1(
                  items: items,
                  backgroundColor: Colors.white,

                  // paddingVertical:5,
                   bottom: 0,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(77),
                  colorSelected:Colors.white,
                  indexSelected: tabsRouter.activeIndex,
                  countStyle: const CountStyle(color: Colors.black),
                  onTap: (int index) {
                    if(index==0){
                      context.router.push(const CreateVisitRoute());
                      return;
                    }
                     tabsRouter.setActiveIndex(index);
                     changeIndex(index);
                  },
                  onAnimateFirstIndexDone: (){
                    print('animate done ');

                  },


                  titleStyle:  const TextStyle(
                    color: Color(0xFF090909),
                    fontWeight:FontWeight.w700 ,

                    fontSize: 12,
                  ),
                  animated: true, backgroundSelected: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        );
      },



    );


  }
}



class _TabsListenerWrapper extends StatefulWidget {
  final TabsRouter tabsRouter;
  final Widget child;
  final Function(int) onChange;

  const _TabsListenerWrapper({
    Key? key,
    required this.tabsRouter,
    required this.child,
    required this.onChange,
  }) : super(key: key);

  @override
  State<_TabsListenerWrapper> createState() => _TabsListenerWrapperState();
}

class _TabsListenerWrapperState extends State<_TabsListenerWrapper> {
  @override
  void initState() {
    super.initState();
    widget.tabsRouter.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    print('Switched to tab: ${widget.tabsRouter.activeIndex}');
    widget.onChange(widget.tabsRouter.activeIndex);
    // Add analytics, logic, state updates here
  }

  @override
  void dispose() {
    widget.tabsRouter.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
