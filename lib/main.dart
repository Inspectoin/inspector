import 'package:flutter/material.dart';


import 'package:inspector/domain/core/utils/app_environment.dart';
import 'package:inspector/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inspector/app.dart';
import 'package:inspector/presentation/incident/mock/mewa_mock_data.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureInjection(AppEnvironment.dev);
  // Load the bundled MEWA mock dataset before the first frame so the in-memory
  // facility/visit collections are populated. Remove once a backend exists.
  await MewaMockData.instance.load();

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


