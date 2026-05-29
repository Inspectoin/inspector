//
// import 'package:flutter/material.dart';
// import 'package:into_mobile/domain/core/entities/failures.dart';
// import 'package:into_mobile/domain/core/utils/constants.dart';
//
// typedef OnRetry = Function();
//
// class ErrorView extends StatelessWidget {
//   final String? message;
//   final OnRetry? onRetry;
//   final Failure? failure;
//   final double size;
//   final Map<ServerErrorCode, String>? customMessages;
//
//   const ErrorView(
//       {Key? key,
//       this.message,
//       this.onRetry,
//       this.failure,
//       this.customMessages,
//       this.size = 150})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//           child: Text(
//             _getErrorMessage,
//            // style: Theme.of(context).textTheme.headline6,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         if (onRetry != null ||
//             (failure != null &&
//                 failure is ServerFailure &&
//                 (failure as ServerFailure?)!.errorCode ==
//                     ServerErrorCode.unauthenticated)) ...[
//           const SizedBox(
//             height: 16,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 onRetry?.call();
//               },
//               style: ButtonStyle(
//                   backgroundColor:
//                   WidgetStateProperty.all(Theme.of(context).colorScheme.error),
//                   foregroundColor: WidgetStateProperty.all(
//                       Theme.of(context).cardColor)),
//               child: Text(_getActionText)),
//         ]
//       ],
//     );
//   }
//
//   String get _getErrorMessage {
//     String errorMessage = 'error_message';
//
//     if (failure != null && failure is ServerFailure) {
//       if (failure is ServerFailure) {
//         if ((failure as ServerFailure?)!.errorCode ==
//             ServerErrorCode.noInternetConnection) {
//           errorMessage = 'no_internet_connection_message';
//         } else if ((failure as ServerFailure?)!.errorCode ==
//             ServerErrorCode.forbidden) {
//           errorMessage = 'access_denied_message';
//         } else if ((failure as ServerFailure?)!.message.isNotEmpty) {
//           errorMessage = (failure as ServerFailure?)!.message;
//         } else if ((failure as ServerFailure?)!.errorCode ==
//             ServerErrorCode.unauthenticated) {
//           errorMessage = 'unauthenticated_message';
//         } else if (customMessages != null && customMessages!.isNotEmpty) {
//           errorMessage =
//               customMessages![(failure as ServerFailure?)!.errorCode]!;
//         }
//       }
//     } else if (message != null) {
//       errorMessage = message!;
//     }
//     return errorMessage;
//   }
//
//   String get _getActionText {
//     String actionText = 'retry';
//
//     if (failure != null && failure is ServerFailure) {
//       if ((failure as ServerFailure?)!.errorCode ==
//           ServerErrorCode.unauthenticated) {
//         actionText = 'login';
//       }
//     }
//
//     return actionText;
//   }
// }
