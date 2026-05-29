import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final List<String> titles;
  final TabController? controller;


  const TabBarWidget({super.key, required this.titles,this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: controller,
          tabs:  [
            for(int i = 0; i<titles.length;i++)...[
              Tab(text: titles[i]),  // Active

            ],
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicator: BoxDecoration(

            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
        ),
    );
  }
}
