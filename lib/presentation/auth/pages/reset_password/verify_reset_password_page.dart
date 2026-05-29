import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/resend_code_bloc/resend_code_bloc.dart';
import 'package:inspector/presentation/auth/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:inspector/presentation/auth/blocs/verify_signup_bloc/verify_sign_up_bloc.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/otp_input_widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerifyResetPasswordPage extends StatefulWidget {
  final String identifier;
  const VerifyResetPasswordPage({
    required this.identifier,
    super.key});

  @override
  State<VerifyResetPasswordPage> createState() => _VerifyResetPasswordPageState();
}

class _VerifyResetPasswordPageState extends State<VerifyResetPasswordPage>  with  ScreenUtils,ScreenLoader{
  final TapGestureRecognizer _tapRecognizer= TapGestureRecognizer();

  TextEditingController codeController=TextEditingController();

  ResetPasswordBloc resetPasswordBloc =getIt<ResetPasswordBloc>();



  @override
  void initState() {
    super.initState();
  }



  @override
  Widget screen(BuildContext context) {
    return  Scaffold(
      appBar: AppBarWidget(titleWidget: Text("reset_password".tr(),
        style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
        ),)),


      body: Container(
        height: MediaQuery.sizeOf(context).height ,
        width: MediaQuery.sizeOf(context).width ,
        padding: const EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            BlocListener<ResetPasswordBloc,BaseState>(
              bloc: resetPasswordBloc,
                listener: (context,state){

                  if(state.isInProgress){
                    startLoading();
                  }else if (state.isFailure){
                    stopLoading();
                    showError(failure: state.failure);
                  }else if (state.isSuccess && state.event is ResetPasswordRequested){
                    stopLoading();
                    showSuccess(customMessage: 'code_sent_to_your_phone_successfully'.tr());
                  }
            },
            child: const SizedBox.shrink(),),




            OtpTextField(
              controller: codeController,
              keyboardType: TextInputType.text,
              onCompleted: (pin) {

                context.router.push(ConfirmResetPasswordRoute(
                  code: codeController.text,
                  identifier: widget.identifier
                ));

              },
            ),
            const  SizedBox(height: 20,),

            Text.rich(
              TextSpan(
                text: 'did_not_receive_code'.tr(),

                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [

                  TextSpan(
                    text: 'resend'.tr()  ,
                    recognizer: _tapRecognizer
                      ..onTap = () {

                        resetPasswordBloc.add(ResetPasswordRequested(identifier: widget.identifier));

                      },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 105,
        child:  Column(

          children: [

            const  SizedBox(height: 10,),


            const  SizedBox(height: 27,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){

                  if( codeController.text.length<6){
                    showError(customMessage: "please_enter_the_code_sent_to_your_phone".tr());
                    return;
                  }
                  context.router.push(ConfirmResetPasswordRoute(
                      code: codeController.text,
                      identifier: widget.identifier
                  ));

                },
                child: Text('next'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }
}
