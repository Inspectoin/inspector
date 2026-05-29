import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    fontFamily: context.locale.languageCode == 'ar' ? 'Tajawal' : 'Poppins',
    //fontFamily: context.locale.languageCode == 'ar' ? 'Tajawal' : 'Tajawal',
    scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
    primaryColor: Colors.black,
    cardColor: const Color(0xffF2F2F2),
    cardTheme:  CardThemeData(color: Colors.grey),
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            )),
    colorScheme: Theme.of(context).colorScheme.copyWith(
      onSecondary: Colors.white,
      primary:AppColors.primaryColor,
      secondary: Colors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.grey,
    ),
    inputDecorationTheme:  InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),

      fillColor: AppColors.textFieldFillColor,
      filled: true,
      labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          ),

      hintStyle: const TextStyle(
          color: AppColors.hintColor,
          fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle:const TextStyle(
          color: Colors.black,
          fontSize: 16,
      ),
      focusedBorder:  OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFe6eaea),
          width: 2
        ),
        borderRadius: BorderRadius.circular(10)
      ),

      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFe6eaea),
          ),
          borderRadius: BorderRadius.circular(10)
      ),

      errorBorder:  OutlineInputBorder(
          borderSide:  const BorderSide(
            color: AppColors.redColor ,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      focusedErrorBorder:  OutlineInputBorder(
          borderSide:  const BorderSide(
            color: AppColors.redColor ,
            width: 2
          ),
          borderRadius: BorderRadius.circular(10)
      ),
   //   border:
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(

      displayLarge: TextStyle(
        color:AppColors.textColor,
        fontWeight: FontWeight.w500,
        fontSize: 24,

      ),

      headlineMedium: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w600,
        fontSize: 20,

      ),
      titleLarge: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,

      ),
      titleMedium: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,

      ),
      bodySmall: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w300,
        fontSize: 12,

      ),
      bodyMedium: TextStyle(
        color: AppColors.textColor,
      ),

      bodyLarge: TextStyle(
        color: AppColors.textColor,
      ),
      displayMedium:TextStyle(
        color: AppColors.textColor,
      ),
      displaySmall: TextStyle(
        color: AppColors.textColor,
      ),

    ),

  );
}

