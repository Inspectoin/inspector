import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class ConfirmResetPasswordPage extends StatefulWidget {
  final String code;
  final String identifier;
  const ConfirmResetPasswordPage({super.key,
  required this.code,
  required this.identifier,
  });

  @override
  State<ConfirmResetPasswordPage> createState() => _ConfirmResetPasswordPageState();
}

class _ConfirmResetPasswordPageState extends State<ConfirmResetPasswordPage> with ScreenUtils,ScreenLoader {

  ResetPasswordBloc resetPasswordBloc = getIt<ResetPasswordBloc>();

  AutovalidateMode? autoValidateMode;

  final _formKey = GlobalKey<FormState>();

  bool visiblePassword = true;


  final TextEditingController textEditingControllerPassword=TextEditingController();
  final TextEditingController textEditingControllerConfirmPassword=TextEditingController();

  @override
  Widget screen(BuildContext context) {

    return  Scaffold(
      appBar:  AppBarWidget(
          titleWidget: Text("reset_password".tr())),
      body:  SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [


              BlocListener<ResetPasswordBloc,BaseState>(
                bloc: resetPasswordBloc,
                listener: (context,state){

                  if(state.isInProgress){
                    startLoading();
                  }else if (state.isFailure){
                    stopLoading();
                    showError(failure: state.failure);
                  }else if (state.isSuccess && state.event is ConfirmResetPasswordRequested){

                    stopLoading();

                    var counter =0;
                    context.router.popUntil((route)=> counter++ >= 3);

                    showSuccess(customMessage: 'password_changed_successfully'.tr());


                  }
                },
                child: const SizedBox.shrink(),),


              const SizedBox(height: 30,),
              StatefulBuilder(
                  builder: (context, setStatePassword) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('password'.tr(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const  SizedBox(height: 8,),

                        TextFieldWidget(
                          controller: textEditingControllerPassword,
                          obscureText: visiblePassword,
                          hintText: 'password'.tr(),
                          validator: (value) => Validation.password(value),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[\u0600-\u06FF\u0660-\u0669]')), // Blocks Arabic letters and Arabic numbers
                          ],
                          suffixIcon: IconButton(
                            icon: Icon(
                              !visiblePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              // color: Colors.grey,
                              size: 25,
                            ),
                            tooltip: !visiblePassword ? 'see_password'.tr() : 'hide_password'.tr(),
                            onPressed: () {
                              visiblePassword = !visiblePassword;
                              setStatePassword((){});
                            },
                          ),

                        ),
                        const  SizedBox(height: 34,),

                        Text('confirm_password'.tr(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const  SizedBox(height: 8,),
                        TextFieldWidget(
                          controller: textEditingControllerConfirmPassword,
                          hintText: 'confirm_password'.tr(),
                          obscureText: visiblePassword,
                          validator: (value) => Validation.confirmPassword(value,textEditingControllerPassword.text),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[\u0600-\u06FF\u0660-\u0669]')), // Blocks Arabic letters and Arabic numbers
                          ],
                          suffixIcon: IconButton(
                            icon: Icon(
                              !visiblePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              // color: Colors.grey,
                              size: 25,
                            ),
                            tooltip: !visiblePassword ? 'see_password'.tr() : 'hide_password'.tr(),
                            onPressed: () {
                              visiblePassword = !visiblePassword;
                              setStatePassword((){});
                            },
                          ),
                        ),
                      ],
                    );
                  }
              ),

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
                    resetPasswordBloc.add(ConfirmResetPasswordRequested(
                        code: widget.code,
                        newPassword: textEditingControllerPassword.text
                    ));
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
