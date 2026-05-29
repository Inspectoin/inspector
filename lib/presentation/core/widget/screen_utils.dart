import 'package:another_flushbar/flushbar.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/utils/constants.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

mixin ScreenUtils<T extends StatefulWidget> on State<T> {


  void showError(
      {Failure? failure,
        String? customMessage,
        Map<ServerErrorCode, String>? customMessages}) {
    String message = customMessage ?? "oops_something_went_wrong".tr();

    if (failure != null && failure is ServerFailure) {


      if (failure.message.isNotEmpty) {
        message = failure.message;
      } else if (failure.errorCode == ServerErrorCode.noInternetConnection) {
        message = 'no_internet_connection'.tr();
      } else if (failure.errorCode == ServerErrorCode.forbidden) {
        message = 'access_denied'.tr();
      } else if (failure.errorCode == ServerErrorCode.unauthenticated) {
        message = 'unauthenticated'.tr();
      } else if (customMessages != null && customMessages.isNotEmpty) {
        message = customMessages[failure.errorCode]?.tr() ?? "oops_something_went_wrong".tr();
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        titleColor: Colors.white,
        message: message,
        //margin: EdgeInsets.all(8),
        //borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.BOTTOM,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.linear,
        forwardAnimationCurve: Curves.linear,
        backgroundColor:Theme.of(context).colorScheme.error,


        //backgroundGradient: LinearGradient(colors: [AppColors.primaryColor, Colors.black]),
        isDismissible: true,
        duration: const Duration(seconds: 2),
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),

        showProgressIndicator: false,
        progressIndicatorBackgroundColor: Colors.blueGrey,

      ).show(context);
    });





    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(message.tr()),
    //   backgroundColor: Theme.of(context).colorScheme.error,
    // ));
  }

  void showSuccess({String? customMessage, bool isFloating = true}) {
    String message = customMessage ?? 'success'.tr();




    WidgetsBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        titleColor: Colors.white,

        messageText:Text(message,style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),) ,

        padding:const  EdgeInsets.all(20),
        //margin: EdgeInsets.all(8),
        //borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.BOTTOM,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.linear,
        forwardAnimationCurve: Curves.linear,
        backgroundColor:AppColors.primaryColor,


        //backgroundGradient: LinearGradient(colors: [AppColors.primaryColor, Colors.black]),
        isDismissible: true,
        duration: const Duration(seconds: 2),
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),

        showProgressIndicator: false,
        progressIndicatorBackgroundColor: Colors.blueGrey,

      ).show(context);
    });




    // ScaffoldMessenger.of(context).removeCurrentSnackBar();
    //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(message),
    //    margin: const EdgeInsets.fromLTRB(16, 50, 16, 0), // ضبط المسافة من الأعلى
    //    backgroundColor: Theme.of(context).colorScheme.primary,
    //   behavior: isFloating ? SnackBarBehavior.floating : null,
    // ));
  }

  // Map<String, String> errorContent = {
  //   "no.face.detected": "no_face_detected",
  //   "make.sure.your.full.face.included.in.the.picture": "make_sure_full_face_included",
  //   "multiple.faces.detected": "multiple_faces_detected",
  //   "course.not.found": "course_not_found",
  //   "CodeMismatchException": "CodeMismatchException",
  //   "Incorrect username or password.": "Incorrect username or password.",
  //   "Attempt limit exceeded, please try after some time.": "Attempt limit exceeded, please try after some time.",
  //   "Username/client id combination not found.": "Username/client id combination not found.",
  //   "User does not exist.": "User does not exist.",
  //   "email.already.exist.via.Google": "email.already.exist.via.Google",
  //   "email.already.exist.via.email": "email.already.exist.via.email",
  //   "email.already.exist.via.Facebook": "email.already.exist.via.Facebook",
  //   "email.already.exist.via.Apple": "email.already.exist.via.Apple",
  //   "Invalid verification code provided, please try again.": "Invalid verification code provided, please try again.",
  //   "User is disabled.":"User is disabled.",
  //   "###email.already.exist.via.email":"###email.already.exist.via.email",
  //   "The user cancelled the sign-in flow":"The user cancelled the sign-in flow",
  // };
}
