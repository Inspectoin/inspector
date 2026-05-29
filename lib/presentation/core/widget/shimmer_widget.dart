import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  }) : assert(width == height, 'Circular shimmer must have equal width and height');

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Adjust base color as needed
      highlightColor: Colors.grey[100]!, // Adjust highlight color as needed
      period: const Duration(milliseconds: 1000), // Adjust animation speed
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(

          color: Colors.grey[300]!, // Background color for the shape
          shape: shapeBorder,
        ),
      ),
    );
  }
}

// Example Usage (you can put this in any of your UI files):
/*
// Rectangular shimmer
ShimmerWidget.rectangular(height: 50.0, width: 200.0)

// Rectangular shimmer with custom border radius
ShimmerWidget.rectangular(
  height: 50.0,
  width: 200.0,
  shapeBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
)

// Circular shimmer
ShimmerWidget.circular(width: 50.0, height: 50.0)
*/
