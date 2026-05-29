

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/tab_bar_widget.dart';
import 'package:inspector/presentation/incident/pages/home_page.dart';
import 'package:inspector/presentation/incident/widget/incident_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin{

  late TabController tabController;


  @override
  void initState() {
    tabController=TabController(length: 2, vsync: this);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleWidget:  Text('report_log'.tr()),
      forceShowBackButton: true,
      onBackButtonClicked: (){
        context.router.navigate(const HomeRoute());

      },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),


            Center(
              child: Text('user_specific_guidance'.tr(),
                style: Theme.of(context).textTheme.displayLarge,),
            ),
            const SizedBox(height: 15,),

            Text('list_of_previous_reports'.tr(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                fontSize: 23
              ),),
            const SizedBox(height: 15,),



             SizedBox(
                  height: 50,
                  child:TabBarWidget(
                    controller: tabController,
                    titles: ['active'.tr(),'previous'.tr()],
                  )),

            const SizedBox(height: 15,),

            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                 IncidentList(),
                 IncidentList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
