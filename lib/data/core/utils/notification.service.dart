//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:into_mobile/data/auth/datasources/local/auth_local_datasource.dart';
// import 'package:into_mobile/data/core/datasource/remote/base_remote_datesource.dart';
// import 'package:into_mobile/data/core/utils/app_endpoints.dart';
// import 'package:into_mobile/data/core/utils/configuration/configuration.dart';
// import 'package:into_mobile/data/core/utils/device_info.dart';
// import 'package:into_mobile/injection.dart';
// import 'package:into_mobile/main.dart';
// import 'package:into_mobile/presentation/core/routes/router.dart';
// import 'package:into_mobile/presentation/core/utils/app_snackbar.dart';
// import 'package:into_mobile/presentation/notification/blocs/get_unread_notification_bloc/get_unread_notifications_bloc.dart';
//
// class NotificationService {
//   NotificationService._privateConstructor();
//
//   static final NotificationService _instance = NotificationService._privateConstructor();
//
//   factory NotificationService() {
//     return _instance;
//   }
//   static init() async {
//
//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: true,
//       provisional: false,
//       sound: true,
//     );
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       // alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//   }
//
//   static notificationListeners(BuildContext context) {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
//       var context1 = getIt<AppRouter>().navigatorKey.currentContext!;
//       var local =getIt<AuthLocalDatasource>();
//       if(await local.getSignedInUser() !=null){
//         getIt<GetUnreadNotificationsBloc>().add(GetUnreadNotificationRequested());
//       }
//       AppSnackBar.show(context1, type: AppSnackBarTypes.notifications, message: message.notification?.body ?? '');
//     });
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
//   }
//
//   static addFcmToken() {
//     DeviceInfo deviceInfo =getIt<DeviceInfo>();
//     BaseRemoteDatasource baseRemoteDatasource = getIt<BaseRemoteDatasource>();
//
//     FirebaseMessaging.instance.getToken().then((value) async{
//       baseRemoteDatasource.apiRequest(
//           requestType: RequestType.POST,
//           url: getIt<Configuration>().restApiLearnerBaseUrl +
//               AppEndpoints.ADD_FCM_TOKEN,
//           body: {
//             "source":"mobile",
//             "fingerprint":await deviceInfo.createFingerPrint(),
//             "token": value
//           });
//     });
//   }
//
//   static Future deleteFcmToken() async{
//     DeviceInfo deviceInfo =getIt<DeviceInfo>();
//     BaseRemoteDatasource baseRemoteDatasource = getIt<BaseRemoteDatasource>();
//
//    await baseRemoteDatasource.apiRequest(
//         requestType: RequestType.DELETE,
//         url: getIt<Configuration>().restApiLearnerBaseUrl +
//             AppEndpoints.REMOVE_FCM_TOKEN,
//         body: {
//           "fingerprint":await deviceInfo.createFingerPrint(),
//         });
//   }
// }
