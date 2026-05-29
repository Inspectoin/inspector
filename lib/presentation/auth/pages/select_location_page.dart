
import 'package:auto_route/annotations.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleWidget:  Text(' إبلاغ عن عطل',
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
        ),),
          ),
    );
  }
}
