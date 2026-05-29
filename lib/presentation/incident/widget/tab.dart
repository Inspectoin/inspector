import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const double _kTabHeight = 46.0;

class CustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final Decoration? indicator;
  final Color? indicatorColor;
  final EdgeInsetsGeometry indicatorPadding;
  final double indicatorWeight;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final ValueChanged<int>? onTap;
  final ScrollPhysics? physics;
  final DragStartBehavior dragStartBehavior;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.padding,
    this.indicatorColor,
    this.indicator,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicatorWeight = 2.0,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelPadding,
    this.onTap,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(indicator != null || (indicatorWeight > 0.0)),
        super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();

  @override
  Size get preferredSize {
    double height = 0.0;
    for (final tab in tabs) {
      if (tab is Tab) {
        height = math.max(height, tab.height ?? _kTabHeight);
      } else {
        height = math.max(height, _kTabHeight);
      }
    }
    return Size.fromHeight(height + indicatorWeight);
  }
}

class _CustomTabBarState extends State<CustomTabBar> {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    _controller = widget.controller ?? DefaultTabController.of(context);
    _controller?.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!mounted) return;
    setState(() {
      // rebuild for indicator animation and selected tab updates
    });
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleTabChange);
      _initController();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = _controller!;
    final int tabCount = widget.tabs.length;

    List<Widget> wrappedTabs = List.generate(tabCount, (index) {
      final Widget child = widget.tabs[index];
      final bool selected = index == controller.index;

      final Color? labelColor = selected
          ? widget.labelColor ?? Theme.of(context).tabBarTheme.labelColor
          : widget.unselectedLabelColor ?? Theme.of(context).tabBarTheme.unselectedLabelColor;

      final TextStyle? labelStyle = selected
          ? widget.labelStyle ?? Theme.of(context).tabBarTheme.labelStyle
          : widget.unselectedLabelStyle ?? Theme.of(context).tabBarTheme.unselectedLabelStyle;

      Widget tabItem = DefaultTextStyle(
        style: labelStyle ?? DefaultTextStyle.of(context).style,
        child: IconTheme.merge(
          data: IconThemeData(color: labelColor),
          child: child,
        ),
      );

      tabItem = Padding(
        padding: widget.labelPadding ?? EdgeInsets.symmetric(horizontal: 16),
        child: tabItem,
      );

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.onTap?.call(index);
          controller.animateTo(index);
        },
        child: tabItem,
      );
    });

    Widget tabsRow = widget.isScrollable
        ? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: widget.physics,
      dragStartBehavior: widget.dragStartBehavior,
      child: Row(children: wrappedTabs),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: wrappedTabs,
    );

    // Paint indicator below tabs:
    return Stack(
      children: [
        tabsRow,
        Positioned(
          bottom: 0,
          left: _calculateIndicatorLeft(controller.index, tabCount, context),
          width: _calculateIndicatorWidth(tabCount, context),
          height: widget.indicatorWeight,
          child: _CustomIndicator(
            decoration: widget.indicator,
            color: widget.indicatorColor ?? Theme.of(context).indicatorColor,
            padding: widget.indicatorPadding,
          ),
        ),
      ],
    );
  }

  double _calculateIndicatorLeft(int index, int tabCount, BuildContext context) {
    final double totalWidth = MediaQuery.of(context).size.width;
    if (widget.isScrollable) {
      // For scrollable tabs, indicator left position needs complex logic with scroll controller.
      // Here a simplified version that assumes fixed tabs width:
      // You may improve this with ScrollController offsets.
      return index * (totalWidth / tabCount);
    }
    // For fixed tabs, equal division:
    return (totalWidth / tabCount) * index;
  }

  double _calculateIndicatorWidth(int tabCount, BuildContext context) {
    final double totalWidth = MediaQuery.of(context).size.width;
    return widget.isScrollable ? 60.0 : (totalWidth / tabCount);
  }
}

class _CustomIndicator extends StatelessWidget {
  final Decoration? decoration;
  final Color color;
  final EdgeInsetsGeometry padding;

  const _CustomIndicator({
    Key? key,
    this.decoration,
    required this.color,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If decoration is provided, paint it inside a Container with padding
    if (decoration != null) {
      return Container(
        padding: padding,
        decoration: decoration,
      );
    }

    // Default: simple colored line as indicator
    return Container(
      margin: padding,
      color: color,
    );
  }
}
