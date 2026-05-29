import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
class SecondaryButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  final bool loading;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  const SecondaryButtonWidget({
    required this.onPressed,
    required this.child,
    this.borderSide,
    this.borderRadius,
    this.height,
    this.width,
    this.color,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height ?? 40,
      child: OutlinedButton(
        onPressed: loading ? null : onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(10.0),
              side: borderSide ?? BorderSide(color: color ?? AppColors.primaryColor),
            ),
          ),
          side: WidgetStateProperty.all(
            borderSide ?? BorderSide(color: color ?? AppColors.primaryColor),
          ),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 0)),
          foregroundColor: WidgetStateProperty.all(color ?? AppColors.primaryColor),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: loading
            ? const CircularProgressIndicator()
            : child,
      ),
    );

  } // merge with main
}
