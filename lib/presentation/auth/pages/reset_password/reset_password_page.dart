import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>  with ScreenLoader,ScreenUtils{
  TextEditingController textEditingControllerIdentifier =TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode? autoValidateMode;

  ResetPasswordBloc resetPasswordBloc =getIt<ResetPasswordBloc>();

  @override
  Widget screen(BuildContext context) {
    return  Scaffold(
      appBar: AppBarWidget(titleWidget:Text("reset_password".tr())),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

                    context.router.push(
                      VerifyResetPasswordRoute(
                        identifier: textEditingControllerIdentifier.text,
                      ),
                    );


                  }
                },
                child: const SizedBox.shrink(),),



              const SizedBox(height: 100,),
              Center(
                child: Text('welcome_user'.tr(),
                  style: Theme.of(context).textTheme.displayLarge,),
              ),
              SizedBox(height: 100,),




              Text('email'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerIdentifier,
                hintText: 'email'.tr(),
                validator: (value) => Validation.required(value),

              ),
              const SizedBox(height: 40,),







            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 105,
        child:  Column(

          children: [


            const  SizedBox(height: 27,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){

                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    autoValidateMode =AutovalidateMode.onUserInteraction;
                    setState(() {});
                  } else {


                    resetPasswordBloc.add(ResetPasswordRequested(identifier: textEditingControllerIdentifier.text));

                  }

                },
                child: Text('next'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
