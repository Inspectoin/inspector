
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  final List<Widget> widgets;

  const CustomPageView({
    Key? key,
    required this.pageController,
    required this.widgets,
  }) : super(key: key);
  
  final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController ,
      pageSnapping: true,
        allowImplicitScrolling:false,
      children: widgets);



        // PageViewItem(
        //   index: 0,
        //   image: 'assets/images/image_intro1.png',
        //   title:  'intro_page.title1'.tr(),
        //   highlightedWordsTitle: [ 'intro_page.anytime'.tr(), 'intro_page.anywhere'.tr()],
        //   subTitle:  'intro_page.sub_title1'.tr(),
        //   mobileImage: 'assets/images/mobile_image_intro1.png',
        //   next: (){
        //     pageController!.animateToPage(1,
        //         curve:  Curves.linear, duration: Duration(milliseconds: 300));
        //   },
        //   skip: (){},
        //   back: (){},
        //   bookDoctor: (){},
        //   login: (){},
        // ),
        // PageViewItem(
        //   index: 1,
        //   image: 'assets/images/image_intro2.png',
        //   title: 'intro_page.title2'.tr(),
        //   highlightedWordsTitle: ['intro_page.clinical'.tr(),'intro_page.digital'.tr()],
        //   subTitle: 'intro_page.sub_title2'.tr(),
        //   mobileImage: 'assets/images/mobile_image_intro2.png',
        //   next: (){
        //     pageController!.animateToPage(2,
        //         curve:  Curves.linear, duration: Duration(milliseconds: 300));
        //   },
        //   skip: (){ gotoHomePage(context);},
        //   back: (){
        //     pageController!.animateToPage(0,
        //         curve:  Curves.linear, duration: Duration(milliseconds: 300));
        //   },
        //   bookDoctor: (){
        //
        //   },
        //   login: (){},
        // ),
        // PageViewItem(
        //   index: 2,
        //   image: 'assets/images/image_intro3.png',
        //   title:  'intro_page.title3'.tr(),
        //   highlightedWordsTitle: ['intro_page.telehealth'.tr()],
        //   subTitle:  'intro_page.sub_title3'.tr(),
        //   mobileImage: 'assets/images/mobile_image_intro3.png',
        //   next: (){},
        //   skip: (){  gotoHomePage(context);},
        //
        //   back: (){
        //     pageController!.animateToPage(1,
        //         curve:  Curves.linear, duration: const Duration(milliseconds: 300));
        //   },
        //   bookDoctor: (){
        //     gotoHomePage(context);
        //   },
        //   login: (){
        //    gotoLoginPage(context);
        //   },
        // ),
      //],
    //);
  }

  gotoHomePage(BuildContext context) {
    // serviceLocator<AppSettings>().isFirstRunApp = false;
    // context.router.replace(const MainAppRouter());
  }

  gotoLoginPage(BuildContext context) {
    // serviceLocator<AppSettings>().isFirstRunApp = false;
    // context.router.push(const LoginPageAppRouter());
  }

}