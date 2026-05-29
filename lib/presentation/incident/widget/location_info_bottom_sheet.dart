import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';

class LocationInfoBottomSheet extends StatefulWidget {
  const LocationInfoBottomSheet({super.key});

  @override
  State<LocationInfoBottomSheet> createState() => _LocationInfoBottomSheetState();
}

class _LocationInfoBottomSheetState extends State<LocationInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'hotel_name'.tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFf9f9f9),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: Color(0xffd6d5d5)),
                            ),
                            child: Center(
                              child: Text(
                                'license_number1'.tr(),
                                style: const TextStyle(
                                  color: Color(0xff005F73),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Wrap(
                                children: [
                                  Text(
                                    'directions'.tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Assets.icons.direction.image(fit: BoxFit.cover),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFe9faf0),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Wrap(
                                children: [
                                  Text(
                                    'start'.tr(),
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Assets.icons.directUp.image(fit: BoxFit.cover),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFe9faf0),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Wrap(
                                children: [
                                  Text(
                                    'call'.tr(),
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Assets.icons.call.image(
                                    width: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 0),
                    ],
                  ),
                ),
              ),

              // Images
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Assets.images.imag1.image(
                        height: 180,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Assets.images.image2.image(
                            height: 87,
                            width: MediaQuery.of(context).size.width * 0.45 - 28,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Assets.images.image3.image(
                            height: 87,
                            width: MediaQuery.of(context).size.width * 0.45 - 28,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("overview".tr(),
                      style: const TextStyle(
                          color: Color(0xFF198B73), fontWeight: FontWeight.w600)),
                  Text("updates".tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  Text("reviews".tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  Text("photos".tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),

              const Divider(height: 20),

              // Address & Info
              Row(
                children: [
                  Assets.icons.location.image(
                    width: 20,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      "address1".tr(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Assets.icons.money2Png.image(),
                  const SizedBox(width: 25),
                  Column(
                    children: [
                      Text(
                        "price_range1".tr(),
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        "reported_by".tr(),
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.grayTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Suggest edit
              Row(
                children: [
                  Assets.icons.edit.image(color: AppColors.primaryColor),
                  const SizedBox(width: 25),
                  Text("suggest_edit".tr(), style: const TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
