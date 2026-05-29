import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';

// class StepsProgressWidget extends StatelessWidget {
//   const StepsProgressWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return    Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "step_1_of_3".tr(),
//                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500 ),
//               ),
//               Text(
//                 "${'visit_report'.tr()} VS00010039",
//                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "complete_01".tr(),
//                 style: TextStyle(fontSize: 12, ),
//               ),
//               const SizedBox(width: 12),
//
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(44),
//                   child: LinearProgressIndicator(
//                     value: 0.01,
//                     minHeight: 10,
//
//                     backgroundColor: Color(0xFFE5E5E5),
//                     color:  AppColors.primary2Color,
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class StepsProgressWidget extends StatelessWidget {
  final int currentStep; // 1 → 3
  final String visitNumber;

  const StepsProgressWidget({
    super.key,
    required this.currentStep,
    required this.visitNumber,
  });

  @override
  Widget build(BuildContext context) {
    final totalSteps = 3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "step_of_total".tr(namedArgs: {
                  'current': currentStep.toString(),
                  'total': totalSteps.toString(),
                }),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${'visit_report'.tr()} $visitNumber",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Step progress indicator (3 steps)
          Row(
            children: List.generate(totalSteps, (index) {
              final step = index + 1;
              final bool isCompleted = step <= currentStep;

              return Expanded(
                child: Container(
                  height: 8,
                  margin: EdgeInsetsDirectional.only(end: index == totalSteps - 1 ? 0 : 6),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.primary2Color
                        : const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }),
          ),



        ],
      ),
    );
  }
}
