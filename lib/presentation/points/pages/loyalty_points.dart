import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/tab_bar_widget.dart';
import 'package:inspector/presentation/points/wdiget/point_card_widget.dart';
import 'package:inspector/presentation/points/wdiget/points_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class LoyaltyPointsPage extends StatefulWidget {
  const LoyaltyPointsPage({super.key});

  @override
  State<LoyaltyPointsPage> createState() => _LoyaltyPointsPageState();
}

class _LoyaltyPointsPageState extends State<LoyaltyPointsPage> with SingleTickerProviderStateMixin{

  late TabController tabController;


  @override
  void initState() {
    tabController=TabController(length: 3, vsync: this);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleWidget:  Text('loyalty_points'.tr(),
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
        ),),
        forceShowBackButton: true,
        onBackButtonClicked: (){
          context.router.navigate(const HomeRoute());

        },
      ),


    );
  }
}