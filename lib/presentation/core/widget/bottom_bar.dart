
import 'dart:ui';

import 'package:awesome_bottom_bar_custom/awesome_bottom_bar_custom.dart';
import 'package:awesome_bottom_bar_custom/extension/shadow.dart';
import 'package:awesome_bottom_bar_custom/src/bottom_bar.dart';
import 'package:awesome_bottom_bar_custom/widgets/build_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:awesome_bottom_bar_custom/awesome_bottom_bar_custom.dart';
import 'package:awesome_bottom_bar_custom/extension/shadow.dart';
import 'package:awesome_bottom_bar_custom/widgets/build_icon.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar_custom/src/bottom_bar.dart';

class BottomBarSalomon1 extends StatefulWidget {
  final List<TabItem> items;
  final Function(int index)? onTap;
  final List<BoxShadow>? boxShadow;
  final Curve curve;

  final Duration duration;

  final BorderRadius? radiusSalomon;

  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final int indexSelected;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Color backgroundSelected;
  final double? blur;
  final CountStyle? countStyle;
  final double? heightItem;
  final Color color;
  final bool animated;
  final double? top;
  final double? bottom;
  final bool? enableShadow;
  final Function? onAnimateFirstIndexDone;

  const BottomBarSalomon1({
    Key? key,
    required this.items,
    required this.colorSelected,
    required this.color,
    required this.indexSelected,
    required this.backgroundColor,
    required this.backgroundSelected,
    this.blur,
    this.countStyle,
    this.heightItem = 38,
    this.boxShadow,
    this.onTap,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 300),
    this.radiusSalomon,
    this.iconSize = 22,
    this.titleStyle,
    this.borderRadius,
    this.animated = true,
    this.bottom = 12,
    this.top = 12,
    this.enableShadow = true,
    this.onAnimateFirstIndexDone,
  }) : super(
    key: key,
  );
  @override
  _BottomBarSalomonState createState() => _BottomBarSalomonState();
}

class _BottomBarSalomonState extends State<BottomBarSalomon1> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BuildLayout(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow ?? shadow,
      ),
      blur: widget.blur,
      child: widget.items.isNotEmpty
          ? IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            widget.items.length,
                (index) {
              String value = widget.items[index].key ?? '';

              /// ======
              // Use a unique fallback key if the item key is null or empty
              final String? itemKey = widget.items[index].key;
              final String safeKey =
              (itemKey != null && itemKey.isNotEmpty) ? itemKey : 'bottom_item_$index';

              //return Container(width: 20,height: 20,color: Colros.,)
              /// ========
              ///
              if(index ==0){
                return GestureDetector(
                  // key: Key(value),
                  key: ValueKey(safeKey),
                  onTap:(){

                    if(widget.onTap!=null) widget.onTap?.call(index);
                  },
                  child: widget.items.length > index
                      ? buildItemForFirstIndex(
                    context,
                    item: widget.items[index],
                    color: widget.color,
                    isSelected: index == widget.indexSelected,
                    onAnimationEnd: (){
                      if(widget.onAnimateFirstIndexDone!=null)widget.onAnimateFirstIndexDone!();
                    }
                  )
                      : null,
                );
              }

              return GestureDetector(
                // key: Key(value),
                key: ValueKey(safeKey),
                onTap:(){

                  if(widget.onTap!=null) widget.onTap?.call(index);
                },
                child: widget.items.length > index
                    ? buildItemForNextItems(
                  context,
                  item: widget.items[index],
                  color: widget.color,
                  isSelected: index == widget.indexSelected,
                )
                    : null,
              );
            },
          ),
        ),
      )
          : null,
    );
  }

  Widget buildItem(
      BuildContext context, {
        required TabItem item,
        required Color color,
        bool isSelected = false,
        CountStyle? countStyle,
      }) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
      bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,

    );
    isShadow =true;// widget.enableShadow!;
    Color itemColor = isSelected ? widget.colorSelected : color;

    return Container(
      padding: padDefault,
      child: widget.animated
          ? TweenAnimationBuilder<double>(
        tween: Tween(
          end: isSelected ? 1.0 : 0.0,
        ),
        duration: widget.duration,
        curve: widget.curve,
        builder: (context, t, _) {
          return buildContentItem(
            item,
            itemColor,
            countStyle ?? const CountStyle(size: 12),
            isSelected,
            t,
          );
        },
      )
          : buildContentItem(
        item,
        itemColor,
        countStyle ?? const CountStyle(size: 12),
        isSelected,
        isSelected ? 1 : 0,
      ),
    );
  }


  Widget buildItemForFirstIndex(
      BuildContext context, {
        required TabItem item,
        required Color color,
        bool isSelected = false,
        CountStyle? countStyle,
        required Function onAnimationEnd,
      }) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
    //  bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
      bottom: 12
    );
    isShadow = widget.enableShadow!;
    Color itemColor = isSelected ? widget.colorSelected : color;

    return Container(
      padding: padDefault,
      child: widget.animated
          ? TweenAnimationBuilder<double>(
        tween: Tween(
          end: isSelected ? 1.0 : 0.0,


        ),
        duration: widget.duration,
        curve: widget.curve,

        onEnd: () {
          if (isSelected) {
            // ✅ Do something after the animation ends
            debugPrint('Animation finished for ${item.title}');
            onAnimationEnd();

          }
        },

        builder: (context, t, _) {

          return buildContentItem1(
            item,
            itemColor,
            countStyle ?? const CountStyle(size: 12),
            isSelected,

            t,
          );
        },
      )
          : buildContentItem1(
        item,
        itemColor,
        countStyle ?? const CountStyle(size: 12),
        isSelected,

        isSelected ? 1 : 0,
      ),
    );
  }

  Widget buildContentItem(
      TabItem item,
      Color itemColor,
      CountStyle countStyle,
      bool isSelected,
      double widthFactor,
      ) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 12),
      decoration: BoxDecoration(
        color: isSelected ? widget.backgroundSelected : Colors.transparent,
        borderRadius: widget.radiusSalomon ?? BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: widget.heightItem,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.title is String && item.title == '') ...[
              Align(
                widthFactor: widthFactor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, left: 20),
                  child: BuildIcon(
                    item: item,
                    iconColor: itemColor,
                    iconSize: widget.iconSize,
                    countStyle: countStyle,
                  ),
                ),
              ),
            ],
            if (item.title is String && item.title != '') ...[
              BuildIcon(
                item: item,
                iconColor: itemColor,
                iconSize: widget.iconSize,
                countStyle: countStyle,
              ),
            ],
            if (item.title is String && item.title != '') ...[
              ClipRect(
                child: Align(
                  widthFactor: widthFactor,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: Text(
                      item.title!,
                      style:
                      Theme.of(context).textTheme.labelSmall?.merge(widget.titleStyle).copyWith(color: itemColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget buildContentItem1(
      TabItem item,
      Color itemColor,
      CountStyle countStyle,
      bool isSelected,
      double widthFactor,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 5),
      decoration: BoxDecoration(
        color: Color.lerp(
          widget.backgroundSelected, // unselected color
          widget.backgroundSelected,    // selected color
          widthFactor,                  // animation progress (0 → 1)
        ),
        borderRadius: BorderRadius.circular(
          lerpDouble(50, 30, widthFactor)!, // 50 = circle, 15 = rounded rectangle
        ),
      ),

      child: SizedBox(
        height: widget.heightItem,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.title is String && item.title == '') ...[
              Align(
                widthFactor: widthFactor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, left: 20),
                  child: BuildIcon(
                    item: item,
                    iconColor: itemColor,
                    iconSize: widget.iconSize,
                    countStyle: countStyle,
                  ),
                ),
              ),
            ],
            if (item.title is String && item.title != '') ...[
              BuildIcon(
                item: item,
                iconColor: itemColor,
                iconSize: widget.iconSize,
                countStyle: countStyle,
              ),
            ],
            if (item.title is String && item.title != '') ...[
              ClipRect(
                child: Align(
                  widthFactor: widthFactor,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: Text(
                      item.title!,
                      style:
                      Theme.of(context).textTheme.labelSmall?.merge(widget.titleStyle).copyWith(color: itemColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }



  Widget buildItemForNextItems(
      BuildContext context, {
        required TabItem item,
        required Color color,
        bool isSelected = false,
        CountStyle? countStyle,
      }) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,
     // bottom: widget.bottom! > 2 ? widget.bottom! + bottom : bottom,
      bottom: 12
    );
    isShadow =true;// widget.enableShadow!;
    Color itemColor = isSelected ? widget.backgroundSelected : color;

    return Container(
      padding: padDefault,
      child: widget.animated
          ? TweenAnimationBuilder<double>(
        tween: Tween(
          end: isSelected ? 1.0 : 0.0,
        ),
        duration: widget.duration,
        curve: widget.curve,
        builder: (context, t, _) {
          return buildContentItem2(
            item,
            itemColor,
            countStyle ?? const CountStyle(size: 12),
            isSelected,
            t,
          );
        },
      )
          : buildContentItem(
        item,
        itemColor,
        countStyle ?? const CountStyle(size: 12),
        isSelected,
        isSelected ? 1 : 0,
      ),
    );
  }

  Widget buildContentItem2(
      TabItem item,
      Color itemColor,
      CountStyle countStyle,
      bool isSelected,
      double widthFactor,
      ) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 12),
      decoration: BoxDecoration(
        color: Colors.transparent ,
        borderRadius: widget.radiusSalomon ?? BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: widget.heightItem,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.title is String && item.title == '') ...[
              Align(
                widthFactor: widthFactor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24, left: 20),
                  child: BuildIcon(
                    item: item,
                    iconColor: itemColor,
                    iconSize: widget.iconSize,
                    countStyle: countStyle,
                  ),
                ),
              ),
            ],
            if (item.title is String && item.title != '') ...[
              BuildIcon(
                item: item,
                iconColor: itemColor,
                iconSize: widget.iconSize,
                countStyle: countStyle,
              ),
            ],
            if (item.title is String && item.title != '') ...[
              ClipRect(
                child: Align(
                  widthFactor: widthFactor,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8),
                    child: Text(
                      item.title!,
                      style:
                      Theme.of(context).textTheme.labelSmall?.merge(widget.titleStyle).copyWith(color: itemColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );  }
}






class BottomBarFloatingSalomon extends StatefulWidget {
  final List<TabItem> items;
  final int indexSelected;
  final Function(int index)? onTap;

  final Color color;
  final Color colorSelected;
  final Color backgroundColor;
  final Color backgroundSelected;

  final double iconSize;
  final TextStyle? titleStyle;
  final double? heightItem;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? top;
  final double? bottom;
  final bool animated;
  final bool? enableShadow;
  final Duration? duration;
  final Curve? curve;

  const BottomBarFloatingSalomon({
    Key? key,
    required this.items,
    this.indexSelected = 0,
    this.onTap,
    required this.color,
    required this.colorSelected,
    required this.backgroundColor,
    required this.backgroundSelected,
    this.iconSize = 25,
    this.titleStyle,
    this.heightItem = 50,
    this.boxShadow,
    this.borderRadius,
    this.top = 12,
    this.bottom = 12,
    this.animated = true,
    this.enableShadow = true,
    this.duration,
    this.curve,
  }) : super(key: key);

  @override
  _BottomBarFloatingSalomonState createState() =>
      _BottomBarFloatingSalomonState();
}

class _BottomBarFloatingSalomonState extends State<BottomBarFloatingSalomon>
    with TickerProviderStateMixin {
  late int _selectedIndex;
  late int _lastSelectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.indexSelected;
    _lastSelectedIndex = widget.indexSelected;
  }

  void _onTap(int index) {
    if (index == _selectedIndex) return;
    _lastSelectedIndex = _selectedIndex;
    _selectedIndex = index;
    widget.onTap?.call(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: BuildLayout(
        decoration: BoxDecoration(
          color: widget.backgroundColor.withOpacity(0.95),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(30),
          boxShadow: widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
        ),
        blur: 10,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(widget.items.length, (index) {
              String safeKey =
                  widget.items[index].key ?? 'bottom_item_$index';

              return Expanded(
                child: GestureDetector(
                  key: ValueKey(safeKey),
                  onTap: () => _onTap(index),
                  child: widget.items.length > index
                      ? index == 0
                      ? _buildItemForFirstTab(
                    widget.items[index],
                    index == _selectedIndex,
                  )
                      : _buildItemForOtherTabs(
                    widget.items[index],
                    index == _selectedIndex,
                  )
                      : null,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildItemForFirstTab(TabItem item, bool isSelected) {
    double widthFactor = isSelected ? 1 : 0;
    Color itemColor = isSelected ? widget.colorSelected : widget.color;

    EdgeInsets padDefault =
    EdgeInsets.only(top: widget.top!, bottom: widget.bottom!);

    return Container(
      padding: padDefault,
      child: widget.animated
          ? TweenAnimationBuilder<double>(
        tween: Tween(end: widthFactor),
        duration: widget.duration ?? const Duration(milliseconds: 300),
        curve: widget.curve ?? Curves.ease,
        builder: (context, t, _) {
          return _buildContentItem1(item, itemColor, isSelected, t);
        },
      )
          : _buildContentItem1(item, itemColor, isSelected, widthFactor),
    );
  }

  Widget _buildContentItem1(
      TabItem item, Color itemColor, bool isSelected, double widthFactor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: Color.lerp(
            widget.backgroundSelected, widget.backgroundSelected, widthFactor),
        borderRadius:
        BorderRadius.circular(lerpDouble(50, 30, widthFactor)!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildIcon(
            item: item,
            iconColor: itemColor,
            iconSize: widget.iconSize,
            countStyle: const CountStyle(size: 12),
          ),
          if (item.title != null && item.title!.isNotEmpty) ...[
            ClipRect(
              child: Align(
                widthFactor: widthFactor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    item.title!,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.merge(widget.titleStyle)
                        .copyWith(color: itemColor),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildItemForOtherTabs(TabItem item, bool isSelected) {
    double widthFactor = isSelected ? 1 : 0;
    Color itemColor = isSelected ? widget.colorSelected : widget.color;

    EdgeInsets padDefault =
    EdgeInsets.only(top: widget.top!, bottom: widget.bottom!);

    return Container(
      padding: padDefault,
      child: widget.animated
          ? TweenAnimationBuilder<double>(
        tween: Tween(end: widthFactor),
        duration: widget.duration ?? const Duration(milliseconds: 300),
        curve: widget.curve ?? Curves.ease,
        builder: (context, t, _) {
          return _buildContentItem2(item, itemColor, t);
        },
      )
          : _buildContentItem2(item, itemColor, widthFactor),
    );
  }

  Widget _buildContentItem2(TabItem item, Color itemColor, double widthFactor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildIcon(
            item: item,
            iconColor: itemColor,
            iconSize: widget.iconSize,
            countStyle: const CountStyle(size: 12),
          ),
          if (item.title != null && item.title!.isNotEmpty) ...[
            ClipRect(
              child: Align(
                widthFactor: widthFactor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    item.title!,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.merge(widget.titleStyle)
                        .copyWith(color: itemColor),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
