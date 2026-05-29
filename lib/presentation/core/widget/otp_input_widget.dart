import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpTextField extends StatelessWidget {
  final  Function(String)? onCompleted;
  final  TextEditingController controller;
  final  TextInputType keyboardType;
  const OtpTextField({super.key, required this.controller, required this.onCompleted,this.keyboardType=TextInputType.number,});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        keyboardType: keyboardType,
        controller: controller,
        // inputFormatters: [
        // //  FilteringTextInputFormatter.digitsOnly,
        //
        // ],
        defaultPinTheme: PinTheme(
          height: 50,
          width: 50,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE6EAF0)),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        submittedPinTheme: PinTheme(
          height: 50,
          width: 50,
          textStyle: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        length: 6,
        // pinAnimationType: PinAnimationType.rotation,
        showCursor: true,
        onCompleted: onCompleted,
        onChanged: (value) {},
      ),
    );
  }
}
