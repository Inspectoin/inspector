import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/auth/pages/select_mode_page.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/loader.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/secondary_button.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;
@RoutePage()
class ProfileGuestPage extends StatefulWidget {
  const ProfileGuestPage({super.key});

  @override
  State<ProfileGuestPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileGuestPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(titleWidget:  Text('profile'.tr(),
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24
      ),),
    forceShowBackButton: true,
    onBackButtonClicked: (){

    context.router.navigate(const HomeRouteGuest());

    }),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [









          SizedBox(height: 20,),


          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: const Color(0xFFe5e5e5)
                )
            ),

            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            child: Column(
              children: [

                item('privacy_policy'.tr(),(){

                }, Assets.icons.shieldSecurity.image(
                    width: 24,
                    height: 24
                ),),
                SizedBox(height: 20,),

                item('about_app'.tr(),(){

                }, Assets.icons.information.image(
                    width: 24,
                    height: 24
                ),),
                SizedBox(height: 20,),

                item('contact_us'.tr(),(){

                }, Assets.icons.call.image(
                    width: 24,
                    height: 24
                ),),
                SizedBox(height: 20,),


                item('view_consumer_rights_and_duties'.tr(),(){

                }, Assets.icons.documentFavorite.image(
                    width: 24,
                    height: 24
                ),),
                SizedBox(height: 20,),

                item('language'.tr(),(){

                  _showLanguageMenu();

                }, Assets.icons.global.image(
                    width: 24,
                    height: 24
                ),key: _buttonKey),

              ],
            ),
          ),
          SizedBox(height: 20,),

          SecondaryButtonWidget(
            color: AppColors.redColor,
              onPressed: (){
                context.router.pushAndPopUntil(const SelectModeRoute(), predicate: (route)=>false);



              }, child: Text('logout'.tr())),

          SizedBox(height: 20,),


          SizedBox(height: 20,),


        ],
      ),
    ),

    );
  }

  Widget item(title,Function onTap,Widget icon,{dynamic key}){

    return InkWell(
      onTap: (){onTap();},
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        key: key,
        height: 40,
        child: Row(
          children: [
            icon,
            SizedBox(width: 10,),

            Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),),

            const Spacer(),

            Transform(
              alignment: Alignment.center,
              transform: Directionality.of(context) == ui.TextDirection.rtl
                  ? Matrix4.rotationY(3.14159)  // flip horizontally
                  : Matrix4.identity(),
              child: Assets.icons.arrowRight.image(
                  width: 24,
                  height: 24
              ),
            ),

          ],
        ),
      ),
    );
  }

  final GlobalKey _buttonKey = GlobalKey();

  void _showLanguageMenu() async {
    final RenderBox button = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final selectedLang = await showMenu<String>(
      context: context,
      position: position,
      items: const [
        PopupMenuItem(
          value: 'en',
          child: Text('English 🇬🇧'),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Text('العربية 🇸🇦'),
        ),
      ],
    );

    if (selectedLang != null) {
      // handle the selected language
     await context.setLocale(Locale(selectedLang));
      print('Selected language: $selectedLang');

      if(SelectModePage.isGuestMode){
        context.router.navigate(HomeRouteGuest());

      }else{
        context.router.navigate(HomeRoute());

      }
      // Example: context.setLocale(Locale(selectedLang));
    }
  }

}
