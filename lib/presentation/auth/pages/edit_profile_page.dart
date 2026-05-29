import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/auth/blocs/update_profile_bloc/update_profile_bloc.dart';
import 'package:inspector/presentation/auth/blocs/update_profile_picture_bloc/update_profile_picture_bloc.dart';
import 'package:inspector/presentation/auth/widget/phone_number_widget.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/validation.dart';
import 'package:inspector/presentation/core/widget/app_bar.widget.dart';
import 'package:inspector/presentation/core/widget/error_widget.dart';
import 'package:inspector/presentation/core/widget/loader.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:inspector/presentation/core/widget/screen_loader.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/text_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with  ScreenLoader,ScreenUtils {
  AuthBloc authBloc =getIt<AuthBloc>();

  UpdateProfileBloc updateProfileBloc =getIt<UpdateProfileBloc>();
  UpdateProfilePictureBloc updateProfilePictureBloc =getIt<UpdateProfilePictureBloc>();

  AutovalidateMode? autoValidateMode;

  final _formKey = GlobalKey<FormState>();


  final TextEditingController textEditingControllerFullName=TextEditingController();
  final TextEditingController textEditingControllerPhoneNumber=TextEditingController();
  final TextEditingController textEditingControllerEmail=TextEditingController();
  final TextEditingController textEditingControllerAddress=TextEditingController();


  GlobalKey<FormFieldState> fullNameFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> phoneNumberFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> addressFieldKey = GlobalKey<FormFieldState>();


  NewPhoneNumber phoneNumber = NewPhoneNumber(
    dialCode: '+966',
  );


  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    authBloc.add(AuthCheckRequested());
    super.initState();
  }
  @override
  Widget screen(BuildContext context) {
    return  Scaffold(
        appBar: AppBarWidget(titleWidget:  Text('profile'.tr(),
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24
          ),),

    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          BlocListener<UpdateProfileBloc, BaseState<User>>(
              bloc: updateProfileBloc,
              listener: (context,state){

            if(state.isInProgress){
              startLoading();
            }else if(state.isFailure){
              stopLoading();
              showError(failure: state.failure);
            }else if(state.isSuccess){
              stopLoading();
              showSuccess(customMessage: 'update_account_success'.tr());
              Navigator.of(context).pop();
            }



          },child: const SizedBox.shrink(),),

          const SizedBox(height: 30,),

          BlocConsumer<AuthBloc,AuthState>(
              bloc: authBloc,
              listener: (context,state){
                if(state is Authenticated){
                  var user =state.user;
                  textEditingControllerFullName.text=user.name;
                  textEditingControllerEmail.text=user.email;
                  // phoneNumber = NewPhoneNumber(
                  //   dialCode: user.phoneCountryCode,
                  //   phoneNumber: user.phoneNumber,
                  // );
                  textEditingControllerPhoneNumber.text=user.phoneNumber;
                }
              },
              builder: (context,state){

                if(state is AuthLoading){
                  return  const Center(child:  Loader());
                }

                if(state is AuthFailure){
                  return  CustomErrorWidget(failure: state.failure,onRetry: (){
                    authBloc.add(AuthCheckRequested());
                  },);
                }

                if(state is Authenticated){
                  var user =state.user;
                  return Form(
                    key: _formKey,
                    autovalidateMode: autoValidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        BlocConsumer<UpdateProfilePictureBloc,BaseState>(
                           bloc: updateProfilePictureBloc,
                            listener: (context,state){},
                            builder: (context,state){

                              if(state.isInProgress){
                                return const  Center(
                                  child:  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Center(child:  Loader()),
                                  ),
                                );

                              }


                             return GestureDetector(
                                onTap: () => _showImageSourceActionSheet(context),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey[300], // Placeholder background
                                        backgroundImage: _profileImage != null
                                            ? FileImage(_profileImage!) // Local image
                                            : (user.profilePictureUrl != null && user.profilePictureUrl!.isNotEmpty
                                            ? NetworkImage(user.profilePictureUrl!) // Online image
                                            : null),
                                        child:Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey[600],
                                        )
                                        ,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2)
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(Icons.edit, color: Colors.white, size: 20),
                                      )
                                    ],
                                  ),
                                ),
                              );


                            }),




                        const SizedBox(height: 30,),








                        Text('full_name'.tr(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const  SizedBox(height: 8,),
                        TextFieldWidget(
                          controller: textEditingControllerFullName,
                          textFieldKey: fullNameFieldKey,
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

                                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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


                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();

              }),

      ],),

    ),
      bottomNavigationBar: Container(
        height: 90,
        child:  Column(

          children: [

            SizedBox(height: 10,),

            SizedBox(
              child: PrimaryButton(
                onPressed: (){


                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    autoValidateMode =AutovalidateMode.onUserInteraction;
                    setState(() {});
                  } else {
                    updateProfileBloc.add(UpdateProfileRequested(
                        fullName: textEditingControllerFullName.text,
                        email: textEditingControllerEmail.text,
                        phone: textEditingControllerPhoneNumber.text.replaceAll(" ", ''),
                        countryCode: phoneNumber.dialCode, ));
                  }
                },
                child: Text('save_changes'.tr() ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Reduce file size
        maxWidth: 800,    // Resize image
        maxHeight: 800,
      );
      if (pickedFile != null) {
        updateProfilePictureBloc.add(UpdateProfilePictureRequested(imagePath: pickedFile.path));
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      showError(customMessage: 'failed_to_pick_image'.tr());
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('select_profile_photo'.tr()),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('camera'.tr()),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('gallery'.tr()),
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: Text('cancel'.tr()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

}
