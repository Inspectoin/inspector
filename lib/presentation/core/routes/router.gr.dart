// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i35;
import 'package:flutter/material.dart' as _i36;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i38;
import 'package:inspector/domain/incident/entities/incident_type_static.dart'
    as _i37;
import 'package:inspector/presentation/auth/pages/change_password_page.dart'
    as _i2;
import 'package:inspector/presentation/auth/pages/edit_profile_page.dart'
    as _i6;
import 'package:inspector/presentation/auth/pages/login_page.dart' as _i15;
import 'package:inspector/presentation/auth/pages/profile_guest_page.dart'
    as _i20;
import 'package:inspector/presentation/auth/pages/profile_page.dart' as _i21;
import 'package:inspector/presentation/auth/pages/register_page.dart' as _i22;
import 'package:inspector/presentation/auth/pages/reset_password/confirm_reset_password_page.dart'
    as _i4;
import 'package:inspector/presentation/auth/pages/reset_password/reset_password_page.dart'
    as _i25;
import 'package:inspector/presentation/auth/pages/reset_password/verify_reset_password_page.dart'
    as _i34;
import 'package:inspector/presentation/auth/pages/select_location_page.dart'
    as _i27;
import 'package:inspector/presentation/auth/pages/select_mode_page.dart'
    as _i28;
import 'package:inspector/presentation/auth/pages/verify_account_page.dart'
    as _i33;
import 'package:inspector/presentation/core/pages/initial_page.dart' as _i11;
import 'package:inspector/presentation/core/pages/intro_page.dart' as _i13;
import 'package:inspector/presentation/core/pages/main_page.dart' as _i17;
import 'package:inspector/presentation/core/pages/main_page_guest.dart' as _i18;
import 'package:inspector/presentation/incident/pages/add_facility_page.dart'
    as _i1;
import 'package:inspector/presentation/incident/pages/chat_with_ai_page.dart'
    as _i3;
import 'package:inspector/presentation/incident/pages/create_visit_page.dart'
    as _i5;
import 'package:inspector/presentation/incident/pages/facilities_page.dart'
    as _i7;
import 'package:inspector/presentation/incident/pages/history_page.dart' as _i8;
import 'package:inspector/presentation/incident/pages/home_page.dart' as _i9;
import 'package:inspector/presentation/incident/pages/home_page_guest.dart'
    as _i10;
import 'package:inspector/presentation/incident/pages/inspection_plan_page.dart'
    as _i12;
import 'package:inspector/presentation/incident/pages/location_page.dart'
    as _i14;
import 'package:inspector/presentation/incident/pages/power_outage_incident_page.dart'
    as _i19;
import 'package:inspector/presentation/incident/pages/report_details_page.dart'
    as _i23;
import 'package:inspector/presentation/incident/pages/report_visit_page.dart'
    as _i24;
import 'package:inspector/presentation/incident/pages/review_report_visit_page.dart'
    as _i26;
import 'package:inspector/presentation/incident/pages/select_visit_type_page.dart'
    as _i29;
import 'package:inspector/presentation/incident/pages/sign_report_page.dart'
    as _i30;
import 'package:inspector/presentation/incident/pages/start_visit_page.dart'
    as _i31;
import 'package:inspector/presentation/incident/pages/tasks_page.dart' as _i32;
import 'package:inspector/presentation/points/pages/loyalty_points.dart'
    as _i16;

/// generated route for
/// [_i1.AddFacilityPage]
class AddFacilityRoute extends _i35.PageRouteInfo<void> {
  const AddFacilityRoute({List<_i35.PageRouteInfo>? children})
      : super(
          AddFacilityRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddFacilityRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddFacilityPage();
    },
  );
}

/// generated route for
/// [_i2.ChangePasswordPage]
class ChangePasswordRoute extends _i35.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i3.ChatWithAiPage]
class ChatWithAiRoute extends _i35.PageRouteInfo<void> {
  const ChatWithAiRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ChatWithAiRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatWithAiRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChatWithAiPage();
    },
  );
}

/// generated route for
/// [_i4.ConfirmResetPasswordPage]
class ConfirmResetPasswordRoute
    extends _i35.PageRouteInfo<ConfirmResetPasswordRouteArgs> {
  ConfirmResetPasswordRoute({
    _i36.Key? key,
    required String code,
    required String identifier,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          ConfirmResetPasswordRoute.name,
          args: ConfirmResetPasswordRouteArgs(
            key: key,
            code: code,
            identifier: identifier,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmResetPasswordRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmResetPasswordRouteArgs>();
      return _i4.ConfirmResetPasswordPage(
        key: args.key,
        code: args.code,
        identifier: args.identifier,
      );
    },
  );
}

class ConfirmResetPasswordRouteArgs {
  const ConfirmResetPasswordRouteArgs({
    this.key,
    required this.code,
    required this.identifier,
  });

  final _i36.Key? key;

  final String code;

  final String identifier;

  @override
  String toString() {
    return 'ConfirmResetPasswordRouteArgs{key: $key, code: $code, identifier: $identifier}';
  }
}

/// generated route for
/// [_i5.CreateVisitPage]
class CreateVisitRoute extends _i35.PageRouteInfo<void> {
  const CreateVisitRoute({List<_i35.PageRouteInfo>? children})
      : super(
          CreateVisitRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateVisitRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i5.CreateVisitPage();
    },
  );
}

/// generated route for
/// [_i6.EditProfilePage]
class EditProfileRoute extends _i35.PageRouteInfo<void> {
  const EditProfileRoute({List<_i35.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i6.EditProfilePage();
    },
  );
}

/// generated route for
/// [_i7.FacilitiesPage]
class FacilitiesRoute extends _i35.PageRouteInfo<FacilitiesRouteArgs> {
  FacilitiesRoute({
    _i7.FacilitiesPageType type = _i7.FacilitiesPageType.list,
    _i36.Key? key,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          FacilitiesRoute.name,
          args: FacilitiesRouteArgs(
            type: type,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FacilitiesRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FacilitiesRouteArgs>(
          orElse: () => const FacilitiesRouteArgs());
      return _i7.FacilitiesPage(
        type: args.type,
        key: args.key,
      );
    },
  );
}

class FacilitiesRouteArgs {
  const FacilitiesRouteArgs({
    this.type = _i7.FacilitiesPageType.list,
    this.key,
  });

  final _i7.FacilitiesPageType type;

  final _i36.Key? key;

  @override
  String toString() {
    return 'FacilitiesRouteArgs{type: $type, key: $key}';
  }
}

/// generated route for
/// [_i8.HistoryPage]
class HistoryRoute extends _i35.PageRouteInfo<void> {
  const HistoryRoute({List<_i35.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i8.HistoryPage();
    },
  );
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i35.PageRouteInfo<void> {
  const HomeRoute({List<_i35.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i9.HomePage();
    },
  );
}

/// generated route for
/// [_i10.HomePageGuest]
class HomeRouteGuest extends _i35.PageRouteInfo<void> {
  const HomeRouteGuest({List<_i35.PageRouteInfo>? children})
      : super(
          HomeRouteGuest.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouteGuest';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i10.HomePageGuest();
    },
  );
}

/// generated route for
/// [_i11.InitialPage]
class InitialRoute extends _i35.PageRouteInfo<void> {
  const InitialRoute({List<_i35.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i11.InitialPage();
    },
  );
}

/// generated route for
/// [_i12.InspectionPlanPage]
class InspectionPlanRoute extends _i35.PageRouteInfo<void> {
  const InspectionPlanRoute({List<_i35.PageRouteInfo>? children})
      : super(
          InspectionPlanRoute.name,
          initialChildren: children,
        );

  static const String name = 'InspectionPlanRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i12.InspectionPlanPage();
    },
  );
}

/// generated route for
/// [_i13.IntroPage]
class IntroRoute extends _i35.PageRouteInfo<void> {
  const IntroRoute({List<_i35.PageRouteInfo>? children})
      : super(
          IntroRoute.name,
          initialChildren: children,
        );

  static const String name = 'IntroRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i13.IntroPage();
    },
  );
}

/// generated route for
/// [_i14.LocationPage]
class LocationRoute extends _i35.PageRouteInfo<LocationRouteArgs> {
  LocationRoute({
    required _i37.IncidentTypeStatic incidentTypeStatic,
    bool isWidget = false,
    _i36.Key? key,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          LocationRoute.name,
          args: LocationRouteArgs(
            incidentTypeStatic: incidentTypeStatic,
            isWidget: isWidget,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationRouteArgs>();
      return _i14.LocationPage(
        incidentTypeStatic: args.incidentTypeStatic,
        isWidget: args.isWidget,
        key: args.key,
      );
    },
  );
}

class LocationRouteArgs {
  const LocationRouteArgs({
    required this.incidentTypeStatic,
    this.isWidget = false,
    this.key,
  });

  final _i37.IncidentTypeStatic incidentTypeStatic;

  final bool isWidget;

  final _i36.Key? key;

  @override
  String toString() {
    return 'LocationRouteArgs{incidentTypeStatic: $incidentTypeStatic, isWidget: $isWidget, key: $key}';
  }
}

/// generated route for
/// [_i15.LoginPage]
class LoginRoute extends _i35.PageRouteInfo<void> {
  const LoginRoute({List<_i35.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginPage();
    },
  );
}

/// generated route for
/// [_i16.LoyaltyPointsPage]
class LoyaltyPointsRoute extends _i35.PageRouteInfo<void> {
  const LoyaltyPointsRoute({List<_i35.PageRouteInfo>? children})
      : super(
          LoyaltyPointsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoyaltyPointsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i16.LoyaltyPointsPage();
    },
  );
}

/// generated route for
/// [_i17.MainPage]
class MainRoute extends _i35.PageRouteInfo<void> {
  const MainRoute({List<_i35.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i17.MainPage();
    },
  );
}

/// generated route for
/// [_i18.MainPageGuest]
class MainRouteGuest extends _i35.PageRouteInfo<void> {
  const MainRouteGuest({List<_i35.PageRouteInfo>? children})
      : super(
          MainRouteGuest.name,
          initialChildren: children,
        );

  static const String name = 'MainRouteGuest';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i18.MainPageGuest();
    },
  );
}

/// generated route for
/// [_i19.PowerOutageIncidentPage]
class PowerOutageIncidentRoute
    extends _i35.PageRouteInfo<PowerOutageIncidentRouteArgs> {
  PowerOutageIncidentRoute({
    required _i38.LatLng latLng,
    _i36.Key? key,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          PowerOutageIncidentRoute.name,
          args: PowerOutageIncidentRouteArgs(
            latLng: latLng,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PowerOutageIncidentRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PowerOutageIncidentRouteArgs>();
      return _i19.PowerOutageIncidentPage(
        latLng: args.latLng,
        key: args.key,
      );
    },
  );
}

class PowerOutageIncidentRouteArgs {
  const PowerOutageIncidentRouteArgs({
    required this.latLng,
    this.key,
  });

  final _i38.LatLng latLng;

  final _i36.Key? key;

  @override
  String toString() {
    return 'PowerOutageIncidentRouteArgs{latLng: $latLng, key: $key}';
  }
}

/// generated route for
/// [_i20.ProfileGuestPage]
class ProfileGuestRoute extends _i35.PageRouteInfo<void> {
  const ProfileGuestRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ProfileGuestRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileGuestRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i20.ProfileGuestPage();
    },
  );
}

/// generated route for
/// [_i21.ProfilePage]
class ProfileRoute extends _i35.PageRouteInfo<void> {
  const ProfileRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i21.ProfilePage();
    },
  );
}

/// generated route for
/// [_i22.RegisterPage]
class RegisterRoute extends _i35.PageRouteInfo<void> {
  const RegisterRoute({List<_i35.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i22.RegisterPage();
    },
  );
}

/// generated route for
/// [_i23.ReportDetailsPage]
class ReportDetailsRoute extends _i35.PageRouteInfo<void> {
  const ReportDetailsRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ReportDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportDetailsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i23.ReportDetailsPage();
    },
  );
}

/// generated route for
/// [_i24.ReportVisitPage]
class ReportVisitRoute extends _i35.PageRouteInfo<void> {
  const ReportVisitRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ReportVisitRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportVisitRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i24.ReportVisitPage();
    },
  );
}

/// generated route for
/// [_i25.ResetPasswordPage]
class ResetPasswordRoute extends _i35.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i25.ResetPasswordPage();
    },
  );
}

/// generated route for
/// [_i26.ReviewReportVisitPage]
class ReviewReportVisitRoute extends _i35.PageRouteInfo<void> {
  const ReviewReportVisitRoute({List<_i35.PageRouteInfo>? children})
      : super(
          ReviewReportVisitRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReviewReportVisitRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i26.ReviewReportVisitPage();
    },
  );
}

/// generated route for
/// [_i27.SelectLocationPage]
class SelectLocationRoute extends _i35.PageRouteInfo<void> {
  const SelectLocationRoute({List<_i35.PageRouteInfo>? children})
      : super(
          SelectLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectLocationRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i27.SelectLocationPage();
    },
  );
}

/// generated route for
/// [_i28.SelectModePage]
class SelectModeRoute extends _i35.PageRouteInfo<void> {
  const SelectModeRoute({List<_i35.PageRouteInfo>? children})
      : super(
          SelectModeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectModeRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i28.SelectModePage();
    },
  );
}

/// generated route for
/// [_i29.SelectVisitTypePage]
class SelectVisitTypeRoute extends _i35.PageRouteInfo<void> {
  const SelectVisitTypeRoute({List<_i35.PageRouteInfo>? children})
      : super(
          SelectVisitTypeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectVisitTypeRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i29.SelectVisitTypePage();
    },
  );
}

/// generated route for
/// [_i30.SignReportPage]
class SignReportRoute extends _i35.PageRouteInfo<void> {
  const SignReportRoute({List<_i35.PageRouteInfo>? children})
      : super(
          SignReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignReportRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i30.SignReportPage();
    },
  );
}

/// generated route for
/// [_i31.StartVisitPage]
class StartVisitRoute extends _i35.PageRouteInfo<void> {
  const StartVisitRoute({List<_i35.PageRouteInfo>? children})
      : super(
          StartVisitRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartVisitRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i31.StartVisitPage();
    },
  );
}

/// generated route for
/// [_i32.TasksPage]
class TasksRoute extends _i35.PageRouteInfo<void> {
  const TasksRoute({List<_i35.PageRouteInfo>? children})
      : super(
          TasksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i32.TasksPage();
    },
  );
}

/// generated route for
/// [_i33.VerifyAccountPage]
class VerifyAccountRoute extends _i35.PageRouteInfo<VerifyAccountRouteArgs> {
  VerifyAccountRoute({
    String? phone,
    _i36.Key? key,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          VerifyAccountRoute.name,
          args: VerifyAccountRouteArgs(
            phone: phone,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyAccountRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyAccountRouteArgs>(
          orElse: () => const VerifyAccountRouteArgs());
      return _i33.VerifyAccountPage(
        phone: args.phone,
        key: args.key,
      );
    },
  );
}

class VerifyAccountRouteArgs {
  const VerifyAccountRouteArgs({
    this.phone,
    this.key,
  });

  final String? phone;

  final _i36.Key? key;

  @override
  String toString() {
    return 'VerifyAccountRouteArgs{phone: $phone, key: $key}';
  }
}

/// generated route for
/// [_i34.VerifyResetPasswordPage]
class VerifyResetPasswordRoute
    extends _i35.PageRouteInfo<VerifyResetPasswordRouteArgs> {
  VerifyResetPasswordRoute({
    required String identifier,
    _i36.Key? key,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          VerifyResetPasswordRoute.name,
          args: VerifyResetPasswordRouteArgs(
            identifier: identifier,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyResetPasswordRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyResetPasswordRouteArgs>();
      return _i34.VerifyResetPasswordPage(
        identifier: args.identifier,
        key: args.key,
      );
    },
  );
}

class VerifyResetPasswordRouteArgs {
  const VerifyResetPasswordRouteArgs({
    required this.identifier,
    this.key,
  });

  final String identifier;

  final _i36.Key? key;

  @override
  String toString() {
    return 'VerifyResetPasswordRouteArgs{identifier: $identifier, key: $key}';
  }
}
