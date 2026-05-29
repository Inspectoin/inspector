import 'dart:async';
import 'dart:math';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/incident/pages/aa.dart';
import 'package:inspector/presentation/incident/pages/electricity_theft_incident_page.dart';
import 'package:inspector/presentation/incident/widget/circle_motion_pointer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatWithAiPage extends StatefulWidget {
  const ChatWithAiPage({super.key});

  @override
  State<ChatWithAiPage> createState() => _ChatWithAiPageState();
}

class _ChatWithAiPageState extends State<ChatWithAiPage>   with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? recordedFilePath;

  int selectedIndex=-1;

  @override
  void initState() {
    super.initState();

    _heights = List<double>.filled(barCount, minBarHeight);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }


  int step =1;

  bool  showLoadingAi=false;
  bool  showAiResult=false;


  bool isRecording = false;
  Timer? _timer;
  final Random _rnd = Random();

  // Wave configuration
  final int barCount = 40;
  final double minBarHeight = 6;
  final double maxBarHeight = 40;
  final Duration updateInterval = const Duration(milliseconds: 160);
  final Duration animationDuration = const Duration(milliseconds: 150);

  late List<double> _heights;



  void _startMockWave() {
    if (isRecording) return;
    setState(() => isRecording = true);

    _timer = Timer.periodic(updateInterval, (_) {
      setState(() {
        _heights = List.generate(
          barCount,
              (i) {
            // create a more "natural" wave by using a base sine + randomness
            final base = (sin((DateTime.now().millisecondsSinceEpoch / 1000.0) * (0.6 + i * 0.03) + i) + 1) / 2;
            final noise = _rnd.nextDouble() * 0.6;
            final value = minBarHeight + (base * (1 - noise) + noise) * (maxBarHeight - minBarHeight);
            return value;
          },
        );
      });
    });
  }

  void _stopMockWave() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      isRecording = false;
      // shrink back to minimal
      _heights = List<double>.filled(barCount, minBarHeight);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:  AppBarWidget(titleWidget: Text('chat_with_ai'.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [

            Builder(
              builder: (context) {

                if(step==1){

                  return  Expanded(child: SizedBox(
                     // reverse: true,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center ,
                        children: [


                          Assets.icons.logo1.image(),
                          const SizedBox(height: 40,),

                          Text('chat_with_ai'.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB1B1B1)
                        ),),
                        ],
                      )));
                }


                if(step==2){

                  return  Expanded(child: SingleChildScrollView(
                    reverse: true,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [

                        const MockOvalWaveDemo(),

                        const SizedBox(height: 40,),
                        // Wave area
                        Container(
                          width: 320,
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0F000000), // subtle
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                              BoxShadow(
                                color: Color(0x1A000000),
                                offset: Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Center(
                            child: WaveBars(
                              heights: _heights,
                              maxHeight: maxBarHeight,
                              spacing: 4,
                              color: Colors.white,
                              duration: animationDuration,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    )));
                }



                if(step ==3){
                  return Expanded(child: SingleChildScrollView(
                    child:Column(
                      children: [
                        const SizedBox(height: 50,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,

                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadiusDirectional.only(
                                        bottomEnd: Radius.circular(9),
                                        bottomStart: Radius.circular(9),
                                        topStart: Radius.circular(9),
                                      )
                                  ),
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width*0.7
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child:Text('ask_for_the_appropriate_report_type'.tr(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),),
                                ),
                                const SizedBox(height: 4,),
                                Text('9:45',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Color(0xFFB1B1B1)
                                  ),)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 0),
                          opacity: showLoadingAi ? 1 : 0,
                          child: showLoadingAi
                              ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1,color: AppColors.secondaryColor)

                                ),
                                child: Assets.icons.smallLogo.image(
                                ),
                              ),
                              const SizedBox(width: 10,),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [

                                      Container(


                                        decoration: BoxDecoration(

                                          borderRadius: const BorderRadiusDirectional.only(
                                            bottomEnd: Radius.circular(9),
                                            bottomStart: Radius.circular(9),
                                            topEnd: Radius.circular(9),
                                          ),
                                          color: const Color(0xFFf9f9f9),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 1),  // like var(--sds-size-depth-025)
                                              blurRadius: 2,         // like var(--sds-size-depth-100)
                                              spreadRadius: 0,
                                              color: Colors.black.withOpacity(0.1), // black-100
                                            ),
                                            BoxShadow(
                                              offset: const Offset(0, 1),
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color: Colors.black.withOpacity(0.2), // black-200
                                            ),
                                          ],
                                        ),

                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width*0.7
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child:Text('generating_results'.tr(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500
                                          ),),
                                      ),
                                      const SizedBox(width: 10,),

                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF1c2b31),

                                        ),
                                        child: Assets.icons.aiLoading.image(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4,),
                                  const Text('9:45',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Color(0xFFB1B1B1)
                                    ),)
                                ],
                              ),


                            ],
                          ): const SizedBox(),
                        ),

                        const SizedBox(height: 25,),

                        AnimatedOpacity(
                            duration: const Duration(milliseconds: 0),
                            opacity: showAiResult ? 1 : 0,
                            child: showAiResult
                                ?
                            Row(
                              children: [
                                Expanded(
                                  child: ChoiceCard(
                                    isChecked: selectedIndex==0,
                                    title:'power_outage'.tr() ,
                                    onChange: (){
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                      context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.ai));

                                    },
                                  ),
                                ),

                                const SizedBox(width: 10,),

                                Expanded(
                                  child: ChoiceCard(
                                    isChecked: selectedIndex==1,

                                    title:'problems_in_the_coffin'.tr() ,
                                    onChange: (){
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                      context.router.push(LocationRoute(incidentTypeStatic: IncidentTypeStatic.ai));
                                    },
                                  ),
                                ),
                              ],
                            )
                                :const SizedBox()
                        )
                      ],
                    ),
                  ));

                }

                return const SizedBox();
              }
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Material(
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      print("Circle tapped!");
                    },

                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
                const SizedBox(width: 5,),

                /// ==============================
                Expanded(child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    filled: true,
                    fillColor: const Color(0xFFF9F9F9),
                    hintText: '',
                    prefixIcon:  Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFf9f9f9),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),  // like var(--sds-size-depth-025)
                            blurRadius: 2,         // like var(--sds-size-depth-100)
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.1), // black-100
                          ),
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.2), // black-200
                          ),
                        ],
                      ),
                      child:isRecording?  GestureDetector(
                          onTap: () {
                            if (isRecording) {
                              step=3;
                              _stopMockWave();
                              Timer(const Duration(milliseconds: 300), () {
                                setState(() {
                                  showLoadingAi=true;
                                });
                              });

                              Timer(const Duration(seconds: 1), () {
                                setState(() {
                                  showAiResult=true;
                                });
                              });
                            } else {
                              step=2;
                              showLoadingAi=false;
                              showAiResult=false;

                              _startMockWave();

                            }
                          },child: Icon(Icons.stop , color:AppColors.primaryColor, size: 34 ,)):
                      GestureDetector(
                          onTap: () {
                            if (isRecording) {
                              step=3;
                              _stopMockWave();
                              Timer(const Duration(seconds: 2), () {
                                setState(() {
                                  showLoadingAi=true;
                                });
                              });

                              Timer(const Duration(seconds: 3), () {
                                setState(() {
                                  showAiResult=true;
                                });
                              });
                            } else {
                              step=2;
                              showLoadingAi=false;
                              showAiResult=false;

                              _startMockWave();

                            }
                          },

                          child: Assets.icons.microphone.image()),
                    ),

                  ),
                ),),



                const SizedBox(width: 14,),

                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(11)
                    ),
                    child: Assets.icons.arrowTop.image()
                ),


              ],
            ),



            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String title;
  final Function onChange;
  final bool isChecked;
  const ChoiceCard({
    required this.title,
    required this.onChange,
    required this.isChecked,
    super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        onChange();
      },
      child: Container(
        decoration: BoxDecoration(
          color:isChecked? AppColors.primaryColor: Colors.white,
          boxShadow:const [
            BoxShadow(
              color:  Color(0x1A000000), // #0000001A (black with 10% opacity)
              offset:  Offset(0, 1),     // x=0, y=1
              blurRadius: 3,                  // 3px blur
              spreadRadius: 0,                // same as in CSS
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const  EdgeInsets.symmetric(vertical: 18),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(title,
              style: TextStyle(
                  color:isChecked? Colors.white: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize:context.locale.languageCode=='ar'? 16: 14

              ),)
          ],
        ),
      ),
    );
  }
}
