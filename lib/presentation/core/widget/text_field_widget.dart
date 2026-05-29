import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;



class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText ;
  final bool readOnly ;
  final bool? enabled;
  final GestureTapCallback? onTap;
  final TextAlignVertical? textAlignVertical;
  final int? maxLines ;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Key? textFieldKey;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextStyle? hintStyle;
  final InputBorder? inputBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.obscureText=false,
    this.readOnly=false,
    this.onTap,
    this.enabled,
    this.textAlignVertical,
    this.maxLines=1,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.textFieldKey,
    this.textAlign=TextAlign.start,
    this.textDirection,
    this.hintStyle,
    this.inputBorder,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.contentPadding,
    this.fillColor,
  });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //textInputAction: TextInputAction.done,
      key: textFieldKey,
      textAlign:textAlign ,
      inputFormatters: inputFormatters,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textAlignVertical: textAlignVertical,
      enabled:enabled ,
      onTap: onTap,
      readOnly: readOnly,
      obscureText: obscureText,
      onChanged: onChanged,
      textDirection:textDirection,
      onEditingComplete: () {
        FocusScope.of(context).unfocus(); // ⬅️ يخفي الكيبورد عند الضغط على Done
      },

      //  textAlign: TextAlign.right,


      validator: (value) {
        if(validator!=null){
          var validation =   validator!(value);



          return validation;
        }
        return null;
      },

      decoration:  InputDecoration(

        fillColor: fillColor,
        contentPadding:contentPadding ,
        hintText: hintText,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorMaxLines: 3,
        border: inputBorder,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        // errorBorder:errorBorder,
        // focusedErrorBorder:focusedErrorBorder,
        disabledBorder:disabledBorder,


      ),

    );
  }
}

