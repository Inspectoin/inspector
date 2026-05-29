import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:easy_localization/easy_localization.dart'; // 1. Import easy_localization
import 'package:flutter/material.dart';

@RoutePage()
class SelectModePage extends StatefulWidget {
  const SelectModePage({super.key});

  @override
  State<SelectModePage> createState() => _SelectModePageState();

  static bool isGuestMode = false;
}

class _SelectModePageState extends State<SelectModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Positioned.fill(child: Assets.images.introLogo.image(
              fit: BoxFit.fitWidth,
            ),),

            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 130,),
                    Assets.icons.blackLogo.image(
                      fit: BoxFit.fitWidth,
                    ),

                    const SizedBox(height: 40,),
                    Text('welcome_title'.tr(), // 2. Use the .tr() extension
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500
                      ),),
                    const SizedBox(height: 30,),

                  ],
                ),
              ),
            )

          ]
      ),
      bottomNavigationBar: Material(
        // elevation:50,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                blurRadius: 10, // Soften the shadow
                spreadRadius: 6, // Extend the shadow
                offset: const Offset(0, -5), // Move shadow down
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              const SizedBox(height: 30,),

              PrimaryButton(onPressed: () {
                SelectModePage.isGuestMode = false;

                context.router.push(const LoginRoute());
              }, child: Text('login'.tr())), // 4. Use the .tr() extension
              const SizedBox(height: 28,)
            ],
          ),
        ),
      ),
    );
  }
}