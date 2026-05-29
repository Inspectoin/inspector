import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IntroSliderWidget extends StatefulWidget {
  final List<String> images;
  final List<String> titles;
  final List<String> subTitles;
  final int activeIndex;
  final Function(int) onChange;

  const IntroSliderWidget({super.key, required this.images, required this.titles, required this.subTitles, this.activeIndex = 0,
  required this.onChange});

  @override
  State<IntroSliderWidget> createState() => _IntroSliderWidgetState();
}

class _IntroSliderWidgetState extends State<IntroSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: CarouselSlider.builder(
              itemBuilder: ((context, index, realIndex) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Image.asset(
                          widget.images[index],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.titles[index],
                     // style: IntoCustomThems.myThemeData.textTheme.bodyLarge?.copyWith(color: IntoConstants.introTitlesColors[index]),
                    ),
                    Text(
                      widget.subTitles[index],
                    //  style: IntoCustomThems.myThemeData.textTheme.bodySmall,
                    ),
                  ],
                );
              }),
              itemCount: widget.images.length,
              options: CarouselOptions(
                autoPlay: true,
                pauseAutoPlayOnManualNavigate: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                height: MediaQuery.of(context).size.height * 0.6,
                clipBehavior: Clip.hardEdge,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1,
                pageSnapping: false,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 2500,
                ),
                autoPlayInterval: const Duration(milliseconds: 2500),
                onPageChanged: (index, reason) {
                  widget.onChange(index);
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}