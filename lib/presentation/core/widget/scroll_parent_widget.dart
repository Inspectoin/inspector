
import 'package:flutter/material.dart';


import 'package:flutter/widgets.dart';

/// A widget that listens to overscroll notifications from its child and manages
/// the scroll offset of a parent scroll view using a provided [ScrollController].
///
/// The [ScrollParentWidget] widget is useful when you want to control the scrolling
/// behavior of a parent scroll view based on the overscroll events of its child.
class ScrollParentWidget extends StatelessWidget {
  /// The [ScrollController] that manages the scrolling of the parent widget.
  final ScrollController controller;

  /// The child widget that will be wrapped by [ScrollParent].
  final Widget child;

  /// Creates a [ScrollParentWidget] widget.
  ///
  /// The [controller] must not be null.
  ScrollParentWidget({required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollNotification>(
      onNotification: (OverscrollNotification value) {
        // If the child scroll view is overscrolled upwards and the new offset is less than or equal to 0,
        // reset the parent scroll view to the top.
        if (value.overscroll < 0 && controller.offset + value.overscroll <= 0) {
          if (controller.offset != 0) controller.jumpTo(0);
          return true;
        }
        // If the child scroll view is overscrolled downwards and the new offset is greater than or equal to
        // the maximum scroll extent, reset the parent scroll view to the bottom.
        if (controller.offset + value.overscroll >= controller.position.maxScrollExtent) {
          if (controller.offset != controller.position.maxScrollExtent) {
            controller.jumpTo(controller.position.maxScrollExtent);
          }
          return true;
        }
        // Update the parent scroll view's offset by the amount of overscroll.
        controller.jumpTo(controller.offset + value.overscroll);
        return true;
      },
      // The child widget that this [ScrollParent] wraps.
      child: child,
    );
  }
}
