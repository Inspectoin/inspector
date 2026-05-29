import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
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
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




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

    context.router.navigate(const HomeRoute());

    }),
    body: RefreshIndicator(
      onRefresh: ()async{
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Center(
                  child: CircleAvatar(radius: 40,),
                ),
                const SizedBox(height: 10,),


                Center(
                  child: Text('ala_daifullah'.tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700

                    ),),
                ),

                const SizedBox(height: 5,),
                Center(
                  child: Text('phone_number'.tr(),
                    textDirection: ui.TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color:  Color(0xFF727478)

                    ),),
                ),
                const SizedBox(height: 5,),


                Center(
                  child: Text('email_address'.tr(),
                    textDirection: ui.TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF727478)

                    ),),
                ),

              ],
            ),




            const SizedBox(height: 30,),

            Row(
              children: [

                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFe5e5e5)
                      )
                    ),

                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    child: Column(
                      children: [
                        Text('visits_count'.tr(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,

                          ),),
                       Text('total_visits'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(

                            fontSize: 13,
                            fontWeight: FontWeight.w500,

                          ),),

                      ],
                    ),
                  ),
                ),

                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                        color: const Color(0xFFe5e5e5)
                      )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('resolved_complaints'.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,

                          ),),

                        Text('complaints_count'.tr(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,

                          ),),


                      ],
                    ),
                  ),
                )
              ],
            ),
              SizedBox(height: 7,),



            SizedBox(height: 20,),

            Row(
              children: [

                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xFFe5e5e5)
                        )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('average_rating'.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),),
                        Text('rating_count'.tr(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,

                          ),),


                      ],
                    ),
                  ),
                ),



              ],
            ),

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
                  // item('edit_profile'.tr(),(){
                  //   context.router.push(const EditProfileRoute());
                  // }, Assets.icons.edit.image(
                  //     width: 24,
                  //     height: 24
                  // ),),
                  // SizedBox(height: 20,),
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
                  // item('change_password'.tr(),(){
                  //   context.router.push(const ChangePasswordRoute());
                  // }, Assets.icons.lock.image(
                  //     width: 24,
                  //     height: 24
                  // ),),
                  // SizedBox(height: 20,),

                  // item('view_consumer_rights_and_duties'.tr(),(){
                  //
                  // }, Assets.icons.documentFavorite.image(
                  // width: 24,
                  //     height: 24
                  // ),),
                  // SizedBox(height: 20,),


                  item('language'.tr(),()async{

                    _showLanguageMenu();

                  }, Assets.icons.global.image(
                      width: 24,
                      height: 24
                  ),key: _buttonKey)
                    ],
              ),
            ),
            SizedBox(height: 20,),

            SecondaryButtonWidget(
              color: AppColors.redColor,
                onPressed: (){
                      context.router.pushAndPopUntil(const SelectModeRoute(), predicate: (route)=>false);


                }, child: Text('logout'.tr())),

            // SizedBox(height: 20,),
            // PrimaryButton(
            //   color: AppColors.redColor,
            //     onPressed: (){
            //       showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: Text("delete_account_confirmation_title".tr()),
            //             content: Text("delete_account_confirmation_message".tr()),
            //             actions: <Widget>[
            //               TextButton(
            //                 onPressed: () => Navigator.of(context).pop(),
            //                 child: Text("cancel".tr()),
            //               ),
            //               TextButton(
            //                 onPressed: () {
            //                   // TODO: call delete account bloc event
            //                   Navigator.of(context).pop();
            //                 },
            //                 child: Text("confirm".tr()),
            //               ),
            //             ],
            //           );
            //         },
            //       );
            //     }, child: Text('delete_account'.tr())),

            SizedBox(height: 20,),


          ],
        ),
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
      items:  [
        PopupMenuItem(
          value: 'en',
          child: Text('english'.tr()),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Text('arabic'.tr()),
        ),
      ],
    );

    if (selectedLang != null) {
      // handle the selected language
      context.setLocale(Locale(selectedLang));
      print('Selected language: $selectedLang');
      // Example: context.setLocale(Locale(selectedLang));
    }
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

}
