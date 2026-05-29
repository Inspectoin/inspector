
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PointsCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF55c6c6),
          borderRadius: BorderRadius.circular(20),
        ),


        child: Stack(
          children: [
            Positioned(
              top: -115,
              left: -115,
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  gradient: RadialGradient(





                    center: Alignment.center,
                    colors: [
                      // const Color(0xFFba4b71).withOpacity(0.9),    // Inner color
                      // const Color(0xFFba4b71).withOpacity(0.8),    // Inner color
                      AppColors.primaryColor,//.withOpacity(0.9),
                      AppColors.primaryColor.withOpacity(0.8),
                     // AppColors.primary2Color.withOpacity(0.78),

                      const Color(0xFF55c6c6).withOpacity(0.8),      // Outer color
                    ],
                    stops: const [0.0, 0.33, 9.0], // Transition from pink to blue at 30%
                    radius: 0.5,

                  ),
                ),





              ),
            ),
            Container(

              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'category_name'.tr(),
                              style: const TextStyle(
                                color: Color(0xFFe9eefe),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                             Text(
                              'electricity_report_app'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 16),

                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(Assets.icons.star.keyName)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPointColumn("consumed".tr(), "350"),
                      _buildPointColumn("available".tr(), "1000"),
                      _buildPointColumn("total_points".tr(), "1350"),
                    ],
                  ),
                ],
              ),
            ),

            // Circular gradient in top-left

          ],
        ),
      ),
    );
  }

  Widget _buildPointColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFe8edff),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
