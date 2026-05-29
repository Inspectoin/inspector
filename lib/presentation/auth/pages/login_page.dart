import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/blocs/session_settings_bloc/session_settings_bloc.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ScreenLoader,ScreenUtils {
  final TapGestureRecognizer _tapRecognizer= TapGestureRecognizer();


TextEditingController textEditingControllerPhone =TextEditingController();
TextEditingController textEditingControllerPassword =TextEditingController();

SessionSettingsBloc sessionSettingsBloc = getIt<SessionSettingsBloc>();
  bool saveLoginSession=true;

  AutovalidateMode? autoValidateMode;

  final _formKey = GlobalKey<FormState>();

  AuthBloc  authBloc = getIt<AuthBloc>();

  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
  String text = "Do Screenshot or Screen Record";
  bool isRecording = false;

  @override
  void initState() {
    authBloc.allowEvents=false;
    sessionSettingsBloc.add(GetSessionStatusRequested());

    screenListener.addScreenRecordListener((recorded) {
      isRecording =recorded;
      setState(() {
        text = recorded ? "Start Recording" : "Stop Recording";
      });
    });

    screenListener.watch();
    super.initState();
  }

  @override
  Widget screen(BuildContext context) {


    return  Scaffold(

      appBar:  AppBarWidget(titleWidget: Text('login.title'.tr(),
        style:  const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
        ),)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              BlocListener<SessionSettingsBloc,BaseState>(
                bloc: sessionSettingsBloc,
                listener: (context,state){
                if(state.isSuccess){
                  saveLoginSession = state.item??true;
                  setState(() {});
                }
              },child:const  SizedBox.shrink(),),


              BlocListener<AuthBloc,AuthState>(
                bloc: authBloc,
                  listener: (_,state){

                    if(state is AuthLoading){
                      startLoading();
                    }else if(state is AuthFailure){
                      stopLoading();
                      showError(failure: state.failure);
                    }else if(state is Unauthenticated){
                      stopLoading();
                      showError(failure: state.failure);
                    } else if(state is  Authenticated){
                      stopLoading();
                      showSuccess(customMessage: 'login_success'.tr());

                        context.router.pushAndPopUntil(
                          const MainRoute(),
                          predicate: (route) => false,
                        );


                    }

                  },
              child: const SizedBox.shrink(),),



              const SizedBox(height: 100,),
              Center(
                child: Text('login.welcome'.tr(),
                style: Theme.of(context).textTheme.displayLarge),
              ),
              const SizedBox(height: 100,),




              Text('login.email_label'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerPhone,
                hintText: 'login.email_label'.tr(),
                validator: (value) => Validation.email(value),

              ),
              const SizedBox(height: 40,),


              Text('login.password_label'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerPassword,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[؀-ۿ٠-٩]')), // Blocks Arabic letters and Arabic numbers
                ],
                hintText: 'login.password_label'.tr(),
                validator: (value) => Validation.password(value),
              ),
              const SizedBox(height: 17,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('dont_forget_login_credentials'.tr(),
                      style: Theme.of(context).textTheme.titleMedium),

                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(value: saveLoginSession,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        onChanged: (v){
                         saveLoginSession=v??false;
                         sessionSettingsBloc.add(SetSessionStatusRequested(newStatus: saveLoginSession));
                         setState(() {});
                        }),
                  )

                ],
              ),
              // InkWell(
              //   onTap: (){
              //     context.router.push(const ResetPasswordRoute());
              //
              //   },
              //
              //   child: Text('login.forgot_password'.tr(),
              //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //         fontWeight: FontWeight.w800
              //       )),
              // ),



            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [
            // const  SizedBox(height: 10,),
            // Text.rich(
            //   TextSpan(
            //     text: 'login.no_account'.tr()  ,
            //     style: const TextStyle(fontSize: 16),
            //     children: [
            //
            //       TextSpan(
            //         text: 'login.register_now'.tr(),
            //         recognizer: _tapRecognizer
            //           ..onTap = () {
            //           context.router.replace(const RegisterRoute());
            //           },
            //       ),
            //
            //     ],
            //   ),
            // ),
            //
            // const  SizedBox(height: 27,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){

                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    autoValidateMode =AutovalidateMode.onUserInteraction;
                    setState(() {});
                  } else {

                    showSuccess(customMessage: 'login_success'.tr());

                    context.router.pushAndPopUntil(
                      const MainRoute(),
                      predicate: (route) => false,
                    );
                  }

                },
                child:  Text('login'.tr() ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    authBloc.allowEvents=true;
    _tapRecognizer.dispose();
    super.dispose();
  }
}
