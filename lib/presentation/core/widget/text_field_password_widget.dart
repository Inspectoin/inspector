import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldPasswordWidget extends StatefulWidget {

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
  final Key? textFieldKey;


  const TextFieldPasswordWidget({
    super.key,
    this.textFieldKey,
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
  });


  @override
  State<TextFieldPasswordWidget> createState() => _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {

  bool isHidden = true;


  @override
  Widget build(BuildContext context) {
    return  TextFieldWidget(
      textFieldKey: widget.textFieldKey,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      textAlignVertical: widget.textAlignVertical,
      enabled:widget.enabled ,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      obscureText: isHidden,
      onChanged: widget.onChanged,
      hintText: widget.hintText,
      validator: widget.validator,

      suffixIcon: IconButton(
        icon: Icon(
          !isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          // color: Colors.grey,
          size: 25,
        ),
        tooltip: !isHidden ? 'see_password'.tr() : 'hide_password'.tr(),
        onPressed: () {
          isHidden = !isHidden;
          setState(() {});
        },
      ),
    );
  }
}
