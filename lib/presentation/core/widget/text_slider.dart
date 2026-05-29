import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AutoTextSliderWithButtons extends StatefulWidget {
  final TextSliderController? controller;
  final Function(int) onChanged;

  const AutoTextSliderWithButtons({Key? key, this.controller, required this.onChanged}) : super(key: key);

  @override
  State<AutoTextSliderWithButtons> createState() => _AutoTextSliderWithButtonsState();
}

class _AutoTextSliderWithButtonsState extends State<AutoTextSliderWithButtons> {
  late PageController _pageController;
  late final List<String> texts;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = widget.controller?.pageController ?? PageController();
    widget.controller?.next = _nextPage;
    widget.controller?.previous = _previousPage;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    texts = [
      'integrated_technical_solution'.tr(),
      'developed_as_meeting_point'.tr(),
      'from_receiving_reports_to_analysis'.tr()
    ];
  }

  void _nextPage() {
    setState(() {
      _currentPage = (_currentPage + 1) % texts.length;
      widget.onChanged(_currentPage);

      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage = (_currentPage - 1 + texts.length) % texts.length;
      widget.onChanged(_currentPage);

      _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 130,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: texts.length,
        itemBuilder: (context, index) {
          if (index == 0) return page1();
          if (index == 1) return page2();
          if (index == 2) return page3();

          return const SizedBox();
        },
      ),
    );
  }

  Widget page1() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.blackLogo.image(
                height: 145,
              ),
            ],
          )),
          Center(
            child: Text(
              texts[0],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget page2() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 170,
              ),
              Assets.icons.balckLogoBigSize.image(
                  //height: 260,
                  ),
            ],
          )),
          Center(
            child: Text(
              texts[1],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget page3() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Text(
              texts[2],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSliderController {
  void Function()? next;
  void Function()? previous;

  PageController pageController = PageController(initialPage: 0);
}