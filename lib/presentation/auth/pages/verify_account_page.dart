import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/resend_code_bloc/resend_code_bloc.dart';
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
class VerifyAccountPage extends StatefulWidget {
  final String? phone;
  const VerifyAccountPage({
    this.phone,
    super.key});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage>  with  ScreenUtils,ScreenLoader{
  final TapGestureRecognizer _tapRecognizer= TapGestureRecognizer();

  TextEditingController codeController=TextEditingController();

  VerifySignUpBloc verifySignUpBloc =getIt<VerifySignUpBloc>();
  ResendCodeBloc resendCodeBloc =getIt<ResendCodeBloc>();



  @override
  Widget screen(BuildContext context) {
    return  Scaffold(
      appBar:  AppBarWidget(titleWidget: Text('verify_account'.tr(),
        style:  const TextStyle(
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

            BlocListener<ResendCodeBloc,BaseState>(
              bloc: resendCodeBloc,
                listener: (context,state){

                  if(state.isInProgress){
                    startLoading();
                  }else if (state.isFailure){
                    stopLoading();
                    showError(failure: state.failure);
                  }else if (state.isSuccess){
                    stopLoading();
                    showSuccess(customMessage: 'code_sent_to_your_phone_successfully'.tr());
                  }
            },
            child: const SizedBox.shrink(),),


            BlocListener<VerifySignUpBloc,BaseState>(
              bloc: verifySignUpBloc,
              listener: (context,state){

                if(state.isInProgress){
                  startLoading();
                }else if (state.isFailure){
                  stopLoading();
                  showError(failure: state.failure);
                }else if (state.isSuccess){
                  stopLoading();
                  showSuccess(customMessage: 'account_verified_successfully'.tr());
                  context.router.pushAndPopUntil(const LoginRoute(), predicate: (route)=>false);
                }
              },
              child: const SizedBox.shrink(),),

            OtpTextField(
              controller: codeController,
              keyboardType: TextInputType.text,
              onCompleted: (pin) {
                verifySignUpBloc.add(VerifySignUpRequested(code: codeController.text));

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

                      if(widget.phone!=null) {
                        resendCodeBloc.add(ResendCodeRequested(phone: widget.phone!));
                      }
                      },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
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
                  verifySignUpBloc.add(VerifySignUpRequested(code: codeController.text));

                },
                child: Text('confirm'.tr() ),
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
