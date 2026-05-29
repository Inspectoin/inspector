import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/incident/widget/report_status_widget.dart';
import 'package:flutter/material.dart';

class SimpleReportWidget extends StatelessWidget {
  final Incident report;
  const SimpleReportWidget({
    required this.report,
    super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
       color: Colors.white
      ),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
      child: Row(
        children: [
          Text('إنارة الشوارع - لا تعمل',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor
        ),),

          const SizedBox(width: 10,),
          Text('#99450',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grayTextColor
            ),),
          Spacer(),

          ReportStatusWidget(report: report)
        ],
      ),
    );
  }

}
