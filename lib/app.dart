import 'package:auto_route/auto_route.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:inspector/presentation/core/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  AuthBloc authBloc = getIt<AuthBloc>()..add(SubscribeToAuthStatus());

  @override
  Widget build(BuildContext context) {


    return  BlocListener<AuthBloc,AuthState>(
        bloc: authBloc,
        listener: (context,state){
      if(state is Unauthenticated && authBloc.allowEvents){
       // _appRouter.pushAndPopUntil(const SelectModeRoute(), predicate: (route)=>false);
      }
    },
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
      child:MaterialApp.router(
          builder: (context, child) => ResponsiveBreakpoints.builder(
        child:   DefaultTextStyle(
            style: TextStyle(
              fontFamily: context.locale.languageCode == 'ar' ? 'Tajawal' : 'Poppins',
            ),child: child!),
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      theme:  getThemeData(context),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate( _appRouter),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      ),
    ));


  }
}
