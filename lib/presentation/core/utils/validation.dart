import 'package:easy_localization/easy_localization.dart';

abstract class Validation {
  //!!==============================================
  static String? password(String? value) {
    RegExp passwordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\s]).{8,}$',
    );


    if (value == null || value.isEmpty || value.length<8) {
      return "password_requirement".tr();
    }

    // Use the contains method to check if the password matches the pattern
    return passwordPattern.hasMatch(value ?? '')
        ? null
        : "password_complexity_requirement".tr();
  }

  //!!==============================================
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "confirm_password_required".tr();
    }
    if (value != password) {
      return "passwords_must_match".tr();
    }
    return null;
  }

  //!!==============================================
  static String? email(String? value) {
    final RegExp urlExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return "field_required".tr();
    } else if (!urlExp.hasMatch(value)) {
      return "invalid_email".tr();
    }
    return null;
  }

  //!!==============================================

  static String? phoneNumber(String? value) {
    final RegExp phoneExp = RegExp(r'^\+?\d{8,15}$');

    if (value == null || value.isEmpty) {
      return "phone_required".tr();
    } else if (!phoneExp.hasMatch(value)) {
      return "invalid_phone".tr();
    }
    return null;
  }

  //!!==============================================
  static String? userName(String? value) {
    if (value == null || value.isEmpty) {
      return "username_required".tr();
    }
    if (value.length < 5) {
      return "username_min_length".tr();
    }
    return null;
  }

  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return "field_required".tr();
    }
    return null;
  }

  static String? mustBeMoreThan(String? value, int min) {
    if (value == null || value.isEmpty) {
      return "field_required".tr();
    } else if (value.length <= min) {
      return "must_be_more_than".tr(namedArgs: {"min": "$min"});
    }
    return null;
  }

  static String? mustBeNumberrs(String? value) {
    if (value == null || value.isEmpty) {
      return "field_required".tr();
    } else if (RegExp(r'[^0-9]').hasMatch(value)) {
      return "Only English digits (0-9) are allowed. Please remove any other characters.";
    }
    return null;
  }
}
