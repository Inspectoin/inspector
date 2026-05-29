import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/incident/widget/report_status_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  final Incident report;

  const ReportWidget({super.key,
  required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1,
            color: const Color(0xFFE5E5E5))
      ),
      padding: const EdgeInsets.all(8),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              

              Text.rich(
                TextSpan(
                  text: 'power_outage'.tr()  ,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [

                    TextSpan(
                      text : '#94853',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryColor,

                      ),

                    ),

                  ],
                ),
              ),

              const SizedBox(width: 10,),

              Text('report_type'.tr(),
                style: const TextStyle(fontSize: 18),),

              const Spacer(),

              ReportStatusWidget(report: report)

            ],
          ),

          Text('address'.tr(),
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
          const SizedBox(height: 10,),

          const Text('10/05/2025',
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),


            const SizedBox(width: 10,),


        ],
      ),
    );
  }
}
