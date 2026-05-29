
import 'package:auto_route/auto_route.dart';
import 'package:inspector/presentation/core/routes/router.gr.dart';
import 'package:inspector/presentation/incident/pages/inspection_plan_page.dart';
import 'package:inspector/presentation/incident/pages/review_report_visit_page.dart';
import 'package:inspector/presentation/incident/pages/sign_report_page.dart';

export 'router.gr.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {


  @override
  List<AutoRoute> get routes => [

    /// core
    AutoRoute(page: InitialRoute.page,initial: true),
    AutoRoute(page: IntroRoute.page,),
    AutoRoute(page: RegisterRoute.page,),
    AutoRoute(page: VerifyAccountRoute.page,),
    AutoRoute(page: SelectModeRoute.page,),
    AutoRoute(page: LoginRoute.page,),
    AutoRoute(page: EditProfileRoute.page,),
    AutoRoute(page: ChangePasswordRoute.page,),

    // reset password
    AutoRoute(page: ResetPasswordRoute.page,),
    AutoRoute(page: ConfirmResetPasswordRoute.page,),
    AutoRoute(page: VerifyResetPasswordRoute.page,),

    AutoRoute(page: MainRoute.page,
    path: '/home',
    children:[
      AutoRoute(page: HomeRoute.page,),
      AutoRoute(page: TasksRoute.page,),
      AutoRoute(page: FacilitiesRoute.page,),
      AutoRoute(page: ProfileRoute.page,),

    ]),


    AutoRoute(page: FacilitiesRoute.page,),
    AutoRoute(page: CreateVisitRoute.page,),
    AutoRoute(page: AddFacilityRoute.page,),
    AutoRoute(page: InspectionPlanRoute.page,),

    AutoRoute(page: SelectVisitTypeRoute.page,),



    // incident pages
    AutoRoute(page: LocationRoute.page,),
    AutoRoute(page: PowerOutageIncidentRoute.page,),
   // AutoRoute(page: ElectricityTheftIncidentRoute.page,),
    AutoRoute(page: ChatWithAiRoute.page,),

    AutoRoute(page: StartVisitRoute.page,),
    AutoRoute(page: ReportVisitRoute.page,),
    AutoRoute(page: ReviewReportVisitRoute.page,),
    AutoRoute(page: SignReportRoute.page,),



  ];
}


