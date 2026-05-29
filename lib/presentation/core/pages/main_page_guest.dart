import 'package:auto_route/auto_route.dart';
// import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
// import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_bottom_bar_custom/awesome_bottom_bar_custom.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/auth/pages/profile_page.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
@RoutePage()
class MainPageGuest extends StatefulWidget {
  const MainPageGuest({super.key,});

  @override
  State<MainPageGuest> createState() => _MainPageGuestState();
}

class _MainPageGuestState extends State<MainPageGuest> {

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
        Assets.icons.home.image(
          width: width,
          height: height,
          color:  AppColors.primaryColor,
        ): Assets.icons.homeOutlined.image(
            width: width,
            height: height,

        )
        ,
        title: 'home'.tr(), // Updated
      ),

      TabItem<Widget>(
        icon:index==1 ?
        Assets.icons.report.image(
            width: width,
            height: height,
          color:  AppColors.primaryColor,

        ): Assets.icons.reportOutlined.image(
            width: width,
            height: height
        )
        ,
        title: 'report_log'.tr(), // Updated
      ),

      TabItem<Widget>(
        icon:index==2 ?
        Assets.icons.points.image(
            width: width,
            height: height,
          color:  AppColors.primaryColor,

        ): Assets.icons.pointsOulined.image(
            width: width,
            height: height
        )
        ,
        title: 'loyalty_points'.tr(), // Updated
      ),


      TabItem<Widget>(

        icon:index==3 ?
        Assets.icons.profile.image(
            width: width,
            height: height,
            color: AppColors.primaryColor

        ): Assets.icons.profileOutlined.image(
            width: width,
            height: height,
        ),
        title: 'profile'.tr(), // Updated
      ),

    ];

    return AutoTabsScaffold(
      extendBody: false,
      routes: const  [
        HomeRouteGuest(),
        HistoryRoute(),
        LoyaltyPointsRoute(),
        ProfileGuestRoute()
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
                bottom: 22.0,
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
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                elevation: 5,
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                child: BottomBarFloating(
                  items: items,
                  backgroundColor: Colors.white,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(18),
                  colorSelected:AppColors.primaryColor,
                  indexSelected: tabsRouter.activeIndex,
                  countStyle: const CountStyle(color: Colors.black),
                  onTap: (int index) {
                    // pageViewBloc.goto(index);
                    if(index==1 || index==2) return;

                      tabsRouter.setActiveIndex(index);
                    changeIndex(index);
                  },

                  titleStyle:  const TextStyle(
                    color: Color(0xFF090909),
                    fontWeight:FontWeight.w700 ,
                    fontSize: 10,
                  ),
                  animated: true,
                ),
              ),
            ),
          ),
        );
      },


      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25),

        child: SizedBox(

            width: 60,
            child: FloatingActionButton(

                key: _buttonKey,
                onPressed: (){

                  RenderBox? renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox?;
                  Offset buttonPosition = renderBox!.localToGlobal(Offset.zero);
                  setState(() {
                    _buttonTop = buttonPosition.dy;
                    _buttonLeft = buttonPosition.dx;
                  });




                  showMenu<String>(
                    context: context,

                    //color: Color(0xFFE3E3ED),
                    color:Colors.transparent,
                    elevation: 0,
                    position: RelativeRect.fromDirectional(//LTRB
                      textDirection:context.locale.languageCode=='ar'? ui.TextDirection.rtl : ui.TextDirection.ltr,
                     start:  buttonPosition.dx,
                    top:   buttonPosition.dy-147,
                    end:   buttonPosition.dx - (context.locale.languageCode=='ar'? 60:
                      94) ,//72
                    bottom:   buttonPosition.dy+ renderBox.size.height,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),



                    items: [ PopupMenuItem<String>(
                        enabled: false,
                        padding: const EdgeInsets.all(0),
                        child:  _AnimatedMenuItem(
                            child: Column(
                              children: [
                                _buildMiniButton(
                                  bottom: 0, // not used here anymore
                                  title:'report_an_outage'.tr(),
                                  onTap: () {
                                    Navigator.pop(context); // close menu when clicked
                                    context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.electricityTheft));
                                  },
                                ),
                                const SizedBox(height: 10,),
                                _buildMiniButton(
                                  bottom: 0, // not used here anymore
                                  title: 'theft_of_electricity'.tr(),
                                  onTap: () {
                                    Navigator.pop(context); // close menu when clicked
                                    context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.electricityTheft));

                                  },
                                ),
                                const SizedBox(height: 10,),
                                _buildMiniButton(
                                  bottom: 0, // not used here anymore
                                  title: 'using_ai'.tr(),
                                  onTap: () {
                                    Navigator.pop(context); // close menu when clicked
                                    context.router.push(const ChatWithAiRoute());

                                  },
                                ),
                              ],
                            )
                        ))],
                  );

                },
                backgroundColor: AppColors.primaryColor,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, size: 28,color: Colors.white,))),
      ),


      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(top: 0),
      //   child: SizedBox(
      //      width: 140,
      //      height: 240,
      //
      //       child:   FabMenuFixedExample()
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // 👈 يضعه بالوسط
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,


    );


  }

  Widget _buildMiniButton( {required double bottom,required String title,required Function onTap}) {


    return SizedBox(
      height: 36,
      width: context.locale.languageCode=='ar'? 160:
      200,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        color: Color(0xffF9F9F9),
        child:InkWell(
          onTap: (){
            onTap();

          },
          child: Container(
            padding: EdgeInsetsDirectional.only(
              start: 5,
              end: 5,//15
              top: 5,
              bottom: 5,
            ),

            child:  Container(
              child: Row(
                  children: [

                    // Expanded(child: Container(color: Colors.red,)),
                    // Expanded(child: Container(color: Colors.yellow,)),

                    Assets.icons.addSquare.image(width: 15,color: AppColors.primaryColor),

                    const SizedBox(width: 15,),
                    Text(title),
                  ]
              ),
            ),
          ),
        ),
      ),
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




/// Wrap with animation when menu shows
class _AnimatedMenuItem extends StatefulWidget {
  final Widget child;
  const _AnimatedMenuItem({required this.child});

  @override
  State<_AnimatedMenuItem> createState() => _AnimatedMenuItemState();
}

class _AnimatedMenuItemState extends State<_AnimatedMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _offset = Tween<Offset>(begin: const Offset(0, 0.9), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}
