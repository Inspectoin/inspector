import 'dart:math';

import 'package:inspector/domain/point/entities/point.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AvailablePointWidget extends StatelessWidget {
  final Point point;
  const AvailablePointWidget({super.key,required this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1,
              color: const Color(0xFFE6EAF0))
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('promotion_notes'.tr(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),),




              Text('silver_123'.tr(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                ),),

            ],
          ),

          const SizedBox(height: 5,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              if(Random().nextBool())
                Text(
                  'plus_100_points'.tr(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1FC16B)
                  ),)else

                Text('minus_100_points'.tr(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFB3748)
                  ),),

              Text('june_12_2021'.tr(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF878F99)
                ),),

            ],
          ),

          SizedBox(
            width: 100,
            height: 31,
            child:  PrimaryButton(onPressed: (){}, child: Text('redeem'.tr())),
          )

        ],
      ),
    );
  }
}
