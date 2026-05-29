import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:inspector/app.dart';
import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:inspector/presentation/auth/widget/phone_number_widget.dart';
import 'package:inspector/presentation/auth/widget/phone_widget.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/text_field_password_widget.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>  with ScreenUtils,ScreenLoader{

   final TapGestureRecognizer _tapRecognizer= TapGestureRecognizer();
   AutovalidateMode? autoValidateMode;

   final _formKey = GlobalKey<FormState>();


   final TextEditingController textEditingControllerId=TextEditingController();
   final TextEditingController textEditingControllerUserName=TextEditingController();
   final TextEditingController textEditingControllerFullName=TextEditingController();
  final TextEditingController textEditingControllerPhoneNumber=TextEditingController();
  final TextEditingController textEditingControllerEmail=TextEditingController();
  final TextEditingController textEditingControllerAddress=TextEditingController();
  final TextEditingController textEditingControllerPassword=TextEditingController();
  final TextEditingController textEditingControllerConfirmPassword=TextEditingController();


   GlobalKey<FormFieldState> idFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> userNameFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> fullNameFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> phoneNumberFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> addressFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> passwordFieldKey = GlobalKey<FormFieldState>();
   GlobalKey<FormFieldState> confirmPasswordFieldKey = GlobalKey<FormFieldState>();

   SignUpBloc signUpBloc = getIt<SignUpBloc>();

   NewPhoneNumber phoneNumber = NewPhoneNumber(
     dialCode: '+966',
   );

   bool visiblePassword = true;


   @override
  void initState() {
    super.initState();
  }

   @override
  Widget screen(BuildContext context) {



    return  Scaffold(
      resizeToAvoidBottomInset: true,

      appBar:  AppBarWidget(
          titleWidget:  Text('create_new_account'.tr(),style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24
          ),)),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          autovalidateMode:autoValidateMode ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              BlocListener<SignUpBloc, BaseState<User>>(
                bloc: signUpBloc,
                  listener: (context,state){

                  if(state.isInProgress){
                    startLoading();
                  }else if(state.isFailure){
                    stopLoading();
                    showError(failure: state.failure);
                  }else if(state.isSuccess){
                    stopLoading();
                    showSuccess(customMessage: 'account_created_successfully'.tr());

                    // context.router.push(VerifyAccountRoute(
                    //   phone:phoneNumber.dialCode+ textEditingControllerPhoneNumber.text.replaceAll(" ", ''),
                    // ));
                    context.router.pushAndPopUntil(VerifyAccountRoute(
                      phone:phoneNumber.dialCode+ textEditingControllerPhoneNumber.text.replaceAll(" ", ''),
                    ), predicate: (route)=>false);
                  }


              },
              child: const SizedBox.shrink(),),

              const  SizedBox(height: 50,),
              Text('national_id'.tr(),

              style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerId,
                textFieldKey: idFieldKey,
                hintText: 'national_id'.tr(),
                  validator: (value) => Validation.required(value),
              ),
              const  SizedBox(height: 34,),

              Text('username'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller:textEditingControllerUserName ,
                textFieldKey: userNameFieldKey,
                hintText: 'username'.tr(),
                validator: (value) => Validation.required(value),
              ),
              const  SizedBox(height: 34,),



              Text('full_name'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerFullName ,
                textFieldKey:fullNameFieldKey  ,
                hintText: 'full_name'.tr(),
                validator: (value) => Validation.required(value),
              ),
              const  SizedBox(height: 34,),

          
              Text('mobile_number'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              PhoneNumberWidget(
                  phoneNumber: phoneNumber,
                  controller: textEditingControllerPhoneNumber,
                  textFieldKey: phoneNumberFieldKey,

                  inputDecoration:  InputDecoration(

                      contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      hintText: 'mobile_number_or_national_id'.tr()
                  )),
              const  SizedBox(height: 34,),




          
              Text('email'.tr(),
              style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerEmail,
                textFieldKey: emailFieldKey,
                hintText: 'email'.tr(),
                validator: (value) => Validation.email(value),

              ),
              const  SizedBox(height: 34,),
          
          
              Text('address'.tr(),
                  style: Theme.of(context).textTheme.titleMedium),
              const  SizedBox(height: 8,),
              TextFieldWidget(
                controller: textEditingControllerAddress,
                textFieldKey: addressFieldKey,
                hintText: 'address'.tr(),
               // suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.locat)),
                validator: (value) => Validation.required(value),

              ),
              const  SizedBox(height: 34,),
          






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
                        textFieldKey: passwordFieldKey,
                        obscureText: visiblePassword,
                        hintText: 'password'.tr(),
                        validator: (value) => Validation.password(value),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[؀-ۿ٠-٩]')), // Blocks Arabic letters and Arabic numbers
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
                        textFieldKey: confirmPasswordFieldKey,
                          hintText: 'confirm_password'.tr(),
                        obscureText: visiblePassword,
                        validator: (value) => Validation.confirmPassword(value,textEditingControllerPassword.text),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[؀-ۿ٠-٩]')), // Blocks Arabic letters and Arabic numbers
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
              const  SizedBox(height: 34,),

              const  SizedBox(height: 34,),


            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 140,
        child:  Column(

          children: [

            const  SizedBox(height: 10,),
             Text.rich(
              TextSpan(
                text: 'already_have_an_account'.tr()  ,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [

                  TextSpan(
                    text: 'login'.tr(),
                    style: const TextStyle(

                    ),
                    recognizer: _tapRecognizer
                  ..onTap = () {

                    context.router.replace(const LoginRoute());

                  },
              ),

                ],
              ),
            ),

            const  SizedBox(height: 27,),

            SizedBox(
              child: PrimaryButton(
                onPressed: submitForm,
                child:  Text('next'.tr() ),
              ),
            ),
          ],
        ),
      ),

    );
  }



   void scrollToFirstInvalid() {
     final List<GlobalKey<FormFieldState>> fieldKeys = [
       idFieldKey,
       phoneNumberFieldKey,
       emailFieldKey,
       addressFieldKey,
       passwordFieldKey,
       confirmPasswordFieldKey,
     ];

     for (int i = 0; i < fieldKeys.length; i++) {

       final currentContext = fieldKeys[i].currentContext;
       if (currentContext == null) {
         continue;
       }

       final formFieldState = fieldKeys[i].currentState;
       if (formFieldState == null) {
         continue;
       }

       formFieldState.validate();

       if (!formFieldState.isValid) {
         Scrollable.ensureVisible(
           currentContext,
           duration: const Duration(milliseconds: 300),
           curve: Curves.easeInOut,
         );
         break;
       }
     }
   }





   void submitForm() {


     final isValid = _formKey.currentState!.validate();
     if (!isValid) {
       scrollToFirstInvalid();
       autoValidateMode =AutovalidateMode.onUserInteraction;
       setState(() {});
     } else {
       showSuccess(customMessage: 'account_created_successfully'.tr());


       context.router.pushAndPopUntil(VerifyAccountRoute(
         phone:phoneNumber.dialCode+ textEditingControllerPhoneNumber.text.replaceAll(" ", ''),
       ), predicate: (route)=>false);
     }
   }


   @override
   void dispose() {
     _tapRecognizer.dispose();
     super.dispose();
   }

}
