import 'package:flutter/material.dart';


import 'package:inspector/domain/core/utils/app_environment.dart';
import 'package:inspector/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/app.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureInjection(AppEnvironment.dev);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'),Locale('en'),],
      path: 'assets/translations',
      startLocale:const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      child: const App(),
    ),
  );
}


