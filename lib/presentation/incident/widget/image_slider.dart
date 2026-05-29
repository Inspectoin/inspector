import 'package:carousel_slider/carousel_slider.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ImageSliderWidget extends StatefulWidget {
  const ImageSliderWidget({super.key});

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _currentIndex = 0;

  late final List<Map<String, String>> sliderData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sliderData = [
      {
        "image": "https://picsum.photos/800/400?random=1",
        "title": "head_of_electricity_investigations_states".tr(),
        "subtitle": "you_can_all_be_influential".tr(),
      },
      {
        "image": "https://picsum.photos/800/400?random=2",
        "title": "head_of_electricity_investigations_states".tr(),
        "subtitle": "you_can_all_be_influential".tr(),
      },
      {
        "image": "https://picsum.photos/800/400?random=3",
        "title": "head_of_electricity_investigations_states".tr(),
        "subtitle": "you_can_all_be_influential".tr(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: sliderData.length,
            itemBuilder: (context, index, realIndex) {
              final item = sliderData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item["image"]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 10,
                    start: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"]!,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Text(
                            item["subtitle"]!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 15,
                    start: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 90,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              backgroundColor: AppColors.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "know_more".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOutCubicEmphasized, // 👈 تغيير الانيميشن
              autoPlayAnimationDuration:
                  const Duration(milliseconds: 800), // 👈 مدة الانيميشن
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          // Custom Dots
          PositionedDirectional(
            bottom: 27,
            end: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sliderData.asMap().entries.map((entry) {
                final isActive = _currentIndex == entry.key;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 21 : 11,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isActive ? Colors.teal : Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
