import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/auth/pages/verify_account_page.dart';
import 'package:inspector/presentation/core/blocs/core/wait_for_bloc_completed_extention.dart';
import 'package:inspector/presentation/core/blocs/first_time_bloc/first_time_bloc.dart';
import 'package:inspector/presentation/core/blocs/session_settings_bloc/session_settings_bloc.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {


  AuthBloc authBloc = getIt<AuthBloc>();
  FirstTimeBloc firstTimeBloc =getIt<FirstTimeBloc>();
  SessionSettingsBloc sessionSettingsBloc = getIt<SessionSettingsBloc>();




  @override
  void initState() {
    super.initState();





    Future.delayed(const Duration(milliseconds: 2000)).then((v) {

      context.router.replace(const IntroRoute());

    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: authBloc,
        listener: (context,state){

          /// go to on boarding screen if first time
          if(firstTimeBloc.state.item ==true  ){
            context.router.replace(const IntroRoute());
            firstTimeBloc.add(SetFirstTimeRequested(firstTimeValue: false));
            return;
          }


          if(sessionSettingsBloc.state.item==false){
            authBloc.add(AuthLogout());
           // context.router.replace(const SelectModeRoute());
            return;
          }

          if(state is Authenticated){


            if(state.user.isPhoneVerified){
              context.router.replace(const MainRoute());
            }else {
              var phone  = '${state.user.phoneCountryCode}${state.user.phoneNumber}';
              context.router.replace( VerifyAccountRoute(phone: phone,));
            }


          }
          if(state is Unauthenticated){

            context.router.replace(const SelectModeRoute());
          }

          if(state is AuthFailure){

            context.router.replace(const SelectModeRoute());
          }
        },
        builder: (context,state){
        //return SizedBox();

         /// Todo add retry button

         return Scaffold(
           backgroundColor: AppColors.primaryColor  ,
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    child:Center(
                      child:Center(
                        child: Image.asset('assets/icons/logo.png',
                            width: 145,
                            ),
                      )
                    ),
                  ),



                  Align(
                    alignment: Alignment.bottomCenter,
                    child:    Image.asset('assets/images/splash_image.png',
                        fit: BoxFit.fitWidth  ,
                        width:MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.47),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Text('Powered by LTzam Tech Team.®',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),),
                    ),
                  ),

                ],
              ),
            ),
          );
        });

  }

  // body: Container(
  //               color: Colors.white70,
  //             ),


  @override
  void dispose() {
    getIt<AuthBloc>().allowEvents=true;
    super.dispose();
  }




}
