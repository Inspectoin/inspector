import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/incident/entities/incident_type_static.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/shimmer_widget.dart';
import 'package:inspector/presentation/incident/blocs/hilight_item_bloc/highlight_item_bloc.dart';
import 'package:inspector/presentation/incident/pages/location_page.dart';
import 'package:inspector/presentation/incident/widget/image_slider.dart';
import 'package:inspector/presentation/incident/widget/notification_icon_widget.dart';
import 'package:inspector/presentation/incident/widget/select_incident_type_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final ValueNotifier<String?> selectedType = ValueNotifier<String?>(null);
int selected =-1;

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 85,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform:context.locale.languageCode == 'ar'? (Matrix4.identity()..scale(-1.0, 1.0)): Matrix4.identity()..scale(1.0, 1.0),
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

              var  width=  MediaQuery.of(context).size.width/2 -30;
              var  height =(MediaQuery.of(context).size.height*0.58)/2;

                return Expanded(
                  child: Stack(
                    children: [

                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        child: CardButton(title: 'active'.tr(), onTap: ()async{


                          if(selected!=5){
                            context.router.navigate(const TasksRoute());
                          }
                          selected=0;
                          setState(() {});

                          await  Future.delayed(const Duration(milliseconds:400 ));
                          selectedType.value='active';


                        }, height: height, width: width,
                          icon: Assets.icons.runIcon.image(),
                          isSelected: selected==0,
                        ),
                      ),

                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: CardButton(title: 'scheduled'.tr(), onTap: ()async{


                          if(selected!=5){
                            context.router.navigate(TasksRoute());
                          }
                          selected=1;
                          setState(() {});



                        await  Future.delayed(Duration(milliseconds:400 ));
                          selectedType.value='scheduled';

                        }, height: height, width: width,
                          icon: Assets.icons.calendar.image(),
                          isSelected: selected==1,

                        ),
                      ),




                      PositionedDirectional(
                        bottom: 0,
                        start: 0,
                        child:
                        SizedBox(
                          // clipBehavior: Clip.antiAlias,
                          // color: Colors.transparent,       // The fill color of your container
                          // elevation: 1,
                          // // The shadow elevation you want
                          // shadowColor: Colors.black.withOpacity(0.0), // optional shadow color
                          //
                          //   clipper: ConcaveCornerClipper(
                          //     curveCorner: CurveCorner.topStart,
                          //     curveRadius: 70,
                          //   ),
                                    child: CardButton(title: 'finished'.tr(), onTap: ()async{

                                      if(selected!=5){
                                         context.router.navigate(TasksRoute());
                                      }
                                      selected=2;
                                      setState(() {});

                                      await  Future.delayed(const Duration(milliseconds:400 ));
                                      selectedType.value='finished';

                                    }, height: height, width: width,
                                      icon: Assets.icons.taskCompleted.image(),
                                      isSelected: selected==2,

                                    ),
                                  ),
                        ),


                      PositionedDirectional(
                        bottom: 0,
                        end: 0,
                        child:   SizedBox(

                          child: CardButton(title: 'needs_modification'.tr(), onTap: ()async{

                            if(selected!=5){
                            await  context.router.navigate(TasksRoute());
                            }


                            selected=3;
                            setState(() {});


                            await  Future.delayed(const Duration(milliseconds:400 ));
                            selectedType.value='needs_modification';

                          }, height: height, width: width,
                            icon: Assets.icons.editColored.image(),
                            isSelected: selected==3,

                          ),
                        ),
                      ),


                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (){
                            // if(selected==5) selected=6;
                            // else selected=5;
                            selected=5;
                            setState(() {

                            });
                          },

                          child: AnimatedContainer(
                            onEnd: (){
                              selectedType.value=null;

                              context.router.navigate(TasksRoute());


                            },
                            width:selected==5? 190: 110,
                         //   height:selected==5? 190: 110,
                            duration: Duration(milliseconds: 300),

                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFf5f5f5),

                          ),
                          padding: EdgeInsets.all(  15) ,
                            child: AnimatedContainer(
                              // width:selected==5? 180: 100,
                              // height:selected==5? 180: 100,

                              duration: Duration(microseconds: 600),
                              padding: EdgeInsets.all(  2) ,

                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.background,
                                border: Border.all(width: 2,color: AppColors.primary2Color),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration:BoxDecoration(


                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,

                                    color:selected==5? AppColors.primary2Color : AppColors.background,

                                    border: Border.all(
                                      width:2,
                                      color:AppColors.primary2Color,

                                    )
                                  ),
                                  child: Center(
                                    child: Text('all'.tr(),
                                      style: TextStyle(
                                          color:selected==5?  Colors.white: AppColors.primary2Color,

                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                              ),),
                          ),
                        ),
                      ),


                    ],
                  ),
                );
              }
            )







          ],
        ),
      ),
    );

  }


}

class CardButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Widget icon;
  final double width;
  final double height;
  final bool  isSelected;
  const CardButton({
    required this.title,
    required this.onTap,
    required this.height,
    required this.width,
    required  this.icon,
    this.isSelected=false,
    super.key});

  @override
  Widget build(BuildContext context) {

    return  Material(

      clipBehavior: Clip.antiAlias,
      color: isSelected? AppColors.primary2Color:Colors.white70.withOpacity(0.4),
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20), // 👈 Rounded corners
      ),

    //  borderRadius: BorderRadius.circular(20),
      elevation: 0.5,

      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: width,
          height: height,


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
                    icon,
                    const SizedBox(height: 5,),
                    Text(
                     title,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isSelected ? Colors.white : null
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}


enum CurveCorner {
  topStart,
  topEnd,
  bottomStart,
  bottomEnd,
}
class InnerConcaveCornerClipper extends CustomClipper<Path> {
  final CurveCorner curveCorner;
  final double curveRadius;

  InnerConcaveCornerClipper({
    required this.curveCorner,
    required this.curveRadius,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    switch (curveCorner) {
      case CurveCorner.topStart:
        path.moveTo(curveRadius, 0);
        path.arcToPoint(
          Offset(0, curveRadius),
          radius: Radius.circular(curveRadius),
          clockwise: false, // concave
        );
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width, 0);
        path.close();
        break;

      case CurveCorner.topEnd:
        path.moveTo(0, 0);
        path.lineTo(size.width - curveRadius, 0);
        path.arcToPoint(
          Offset(size.width, curveRadius),
          radius: Radius.circular(curveRadius),
          clockwise: false,
        );
        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        path.close();
        break;

      case CurveCorner.bottomStart:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        path.lineTo(curveRadius, size.height);
        path.arcToPoint(
          Offset(0, size.height - curveRadius),
          radius: Radius.circular(curveRadius),
          clockwise: false,
        );
        path.lineTo(0, 0);
        path.close();
        break;

      case CurveCorner.bottomEnd:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height - curveRadius);
        path.arcToPoint(
          Offset(size.width - curveRadius, size.height),
          radius: Radius.circular(curveRadius),
          clockwise: false,
        );
        path.lineTo(0, size.height);
        path.close();
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}


class ConcaveCornerClipper extends CustomClipper<Path> {
  final CurveCorner curveCorner;
  final double curveRadius;

  ConcaveCornerClipper({
    required this.curveCorner,
    required this.curveRadius,
  });

  @override
  Path getClip(Size size) {
    final rect = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final circle = Path();

    Offset center;

    switch (curveCorner) {
      case CurveCorner.topStart:
        center = Offset(0, 0);
        break;
      case CurveCorner.topEnd:
        center = Offset(size.width, 0);
        break;
      case CurveCorner.bottomStart:
        center = Offset(0, size.height);
        break;
      case CurveCorner.bottomEnd:
        center = Offset(size.width, size.height);
        break;
    }

    circle.addOval(Rect.fromCircle(center: center, radius: curveRadius));

    // Subtract the circle from the rectangle
    return Path.combine(PathOperation.difference, rect, circle);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
