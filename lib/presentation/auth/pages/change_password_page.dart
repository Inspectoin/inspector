import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/change_password_bloc/change_password_bloc.dart';
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
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with ScreenUtils,ScreenLoader {


  ChangePasswordBloc changePasswordBloc =getIt<ChangePasswordBloc>();
  AutovalidateMode? autoValidateMode;

  final _formKey = GlobalKey<FormState>();


  final TextEditingController textEditingControllerOldPassword=TextEditingController();
  final TextEditingController textEditingControllerNewPassword=TextEditingController();


  GlobalKey<FormFieldState> oldPasswordFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> newPasswordFieldKey = GlobalKey<FormFieldState>();

  bool visiblePassword = true;

  @override
  Widget screen(BuildContext context) {
    return  Scaffold(
      appBar: AppBarWidget(titleWidget: Text('change_password'.tr(),)),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<ChangePasswordBloc, BaseState>(
                bloc: changePasswordBloc,
                listener: (context,state){

                  if(state.isInProgress){
                    startLoading();
                  }else if(state.isFailure){
                    stopLoading();
                    showError(failure: state.failure);
                  }else if(state.isSuccess){
                    stopLoading();
                    showSuccess(customMessage: 'password_changed_successfully'.tr());
                    Navigator.of(context).pop();
                  }


                },
                child: const SizedBox.shrink(),),


              StatefulBuilder(
                  builder: (context, setStatePassword) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('password'.tr(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const  SizedBox(height: 8,),

                        TextFieldWidget(
                          controller: textEditingControllerOldPassword,
                          textFieldKey: oldPasswordFieldKey,
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

                        Text('new_password'.tr(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const  SizedBox(height: 8,),
                        TextFieldWidget(
                          controller: textEditingControllerNewPassword,
                          textFieldKey: newPasswordFieldKey,
                          hintText: 'new_password'.tr(),

                          obscureText: visiblePassword,
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
                      ],
                    );
                  }
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [

            const SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){


                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    autoValidateMode =AutovalidateMode.onUserInteraction;
                    setState(() {});
                  } else {
                    changePasswordBloc.add(ChangePasswordRequested(oldPassword: textEditingControllerOldPassword.text
                        , newPassword: textEditingControllerNewPassword.text));
                  }

                },
                child: Text('save'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
