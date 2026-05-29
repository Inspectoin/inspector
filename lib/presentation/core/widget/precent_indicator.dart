
import 'package:flutter/material.dart';

class LinearPercentIndicatorWidget extends StatelessWidget {
  final double percent;
  final Color color;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final double lineHeight;

  const LinearPercentIndicatorWidget({
    Key? key,
    required this.percent,
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.borderRadius,
    this.lineHeight=5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: lineHeight,
      child: ClipRRect(
        borderRadius:borderRadius ?? BorderRadius.circular(5),
        child: LinearProgressIndicator(
          value: percent,
          color: color,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}