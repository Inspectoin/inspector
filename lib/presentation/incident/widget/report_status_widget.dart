import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReportStatusWidget extends StatelessWidget {
  final Incident report;
  const ReportStatusWidget({super.key,required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: getStatusColor(report.status, 'background')
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
      child: Text(report.status=='done'?  'solved'.tr() :'under_review'.tr(),
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: getStatusColor(report.status, 'text')),),
    );
  }


  Color getStatusColor(status,type){
    Map<String,dynamic> colors = {
      'done':{
        'text': AppColors.primaryColor,
        'background':const Color(0xFFe9faf0)
      },
      'review': {
        'text': const Color(0xFFdfb403),
        'background':const Color(0xFFfffbec),
      },

    };

    return  colors[status][type];
  }
}
