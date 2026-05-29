import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsetsDirectional.only(top: 5),
      child: InkWell(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFF9F9F9)
            ),
            child: Stack(
              children: [



                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Blue Rounded Square
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor, // Blue color
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // Notification Dot
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                              BorderSide(
                                color: const Color(0xFFd9ebff),
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Center(
                //   child: Container(
                //     width: 20,
                //     height: 20,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         color: AppColors.primaryColor
                //     ),
                //   ),
                // )

              ],
            ),
          )),
    );
  }
}

