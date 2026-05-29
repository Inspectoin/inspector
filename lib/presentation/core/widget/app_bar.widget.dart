

import 'dart:io';

import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget titleWidget;
  final Widget? subTitleWidget;
  final double toolbarHeight;
  final double radius;
  final bool autoShowBackButton;
  final Color? color;
  final Function? onBackButtonClicked;
  final bool forceShowBackButton;

  const AppBarWidget({
    super.key,
    required this.titleWidget,
    this.subTitleWidget,
    this.radius = 0,
    this.toolbarHeight = 60,
    this.autoShowBackButton = false,
    this.color,
    this.onBackButtonClicked,
    this.forceShowBackButton=false,
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Column(
        children: [
          titleWidget,
          if(subTitleWidget!=null) subTitleWidget!
        ],
      ),
      elevation: 0,
      leadingWidth: 70,

      backgroundColor:color??AppColors.background,// const Color(0xFFF9F9F9),
      centerTitle: true,


      automaticallyImplyLeading: autoShowBackButton,
      // titleSpacing: !autoShowBackButton
      //     ? 40
      //     : _canPop(context)
      //     ? 40
      //    : 0,
      // leading: !autoShowBackButton
      //     ? null
      //     : isFirst
      //     ? null
      //     : Container(
      //   alignment: Alignment.centerRight,
      //   child: IconButton(
      //     icon: Platform.isAndroid
      //         ? const Icon(Icons.arrow_back_rounded)
      //         : const Icon(Icons.arrow_back_ios),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //),
      leading: forceShowBackButton || _canPop(context)
          ? Row(
            children: [
              Container(
                width: 40,
                 height: 40,
                 margin: EdgeInsetsDirectional.only(start: 20),
                 decoration: BoxDecoration(
                   color: AppColors.primaryColor,
                   borderRadius: BorderRadius.circular(10)
                 ),
                child: IconButton(icon:Platform.isAndroid? const
                      Icon(Icons.arrow_back,color: Colors.white,) :
                const Padding(
                          padding: EdgeInsetsDirectional.only(start: 6),
                          child:  Icon(Icons.arrow_back_ios,color: Colors.white,)),
                onPressed: (){
                  if(onBackButtonClicked!= null) {
                    onBackButtonClicked!();
                  } else {
                    Navigator.of(context).pop();
                  }


                }),
              ),
            ],
          )
          : null,


      toolbarHeight: toolbarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  bool _canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }
}
