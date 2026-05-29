import 'package:auto_route/auto_route.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/into_slider_widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/text_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
@RoutePage()
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  final TextSliderController _sliderController = TextSliderController();


  int page =0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final nextButtonWidth = screenWidth * 0.64 -40;
    final skipButtonWidth = screenWidth * 0.36 -20;




    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBarWidget(
        titleWidget:page==0? const Text('') : Text('application_guidelines'.tr()),
      color: Colors.transparent,
        forceShowBackButton:page>0,
        onBackButtonClicked: (){
          if(page>0) _sliderController.previous!();


        },
      ),
      backgroundColor:Colors.white,
      body: Stack(
        children: [
          Positioned.fill(child: Assets.images.introLogo.image(
            fit: BoxFit.fitWidth,

          ),),
          Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [




              AutoTextSliderWithButtons(controller: _sliderController,
              onChanged: (index){
            //    page =_sliderController.pageController.page?.toInt()??0;
                page =index;
                setState(() {});
              },),

              const SizedBox(height: 25),





              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 9,
                          width: 30,

                          decoration: BoxDecoration(
                            color: page == index ? AppColors.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: page == index ?0:1,
                              color:const  Color(0xFFe6eaea)
                            )
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    width:page<2? nextButtonWidth : screenWidth-40,
                    child: PrimaryButton(
                      onPressed: () {
                        if(page<2){
                          _sliderController.next!();

                        }else{
                          context.router.replace(const SelectModeRoute());
                        }

                      },
                      child:  Text(page<2?'next'.tr(): 'login'.tr()),
                    ),
                  ),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: page < 2 ? 20 : 0,
                  ),


                  

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width:page<2? skipButtonWidth :0,
                    child: PrimaryButton(
                      color: const Color(0xFF999999),
                      onPressed: () {
                        context.router.replace(const SelectModeRoute());
                      },
                      child: Text('skip'.tr()),
                    ),
                  ),


                ],
              ),



              const SizedBox(height: 20),

              ]

          ),
              ),
        ],
      ));
  }
}


