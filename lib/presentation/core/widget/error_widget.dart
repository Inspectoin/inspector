import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/utils/constants.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomErrorWidget extends StatelessWidget {
  final Failure? failure;
  final Function onRetry;
  const CustomErrorWidget({
    required this.failure,
    required this.onRetry,
    super.key});

  @override
  Widget build(BuildContext context) {

    String message = "oops_something_went_wrong".tr();

    if (failure != null && failure is ServerFailure) {
      var serverError = failure as ServerFailure;
      if (serverError.message.isNotEmpty) {
       // message = serverError.message;
      } else if (serverError.errorCode == ServerErrorCode.noInternetConnection) {
        message = "no_internet_connection".tr();
      } else if (serverError.errorCode == ServerErrorCode.forbidden) {
        message = "access_denied".tr();
      } else if (serverError.errorCode == ServerErrorCode.unauthenticated) {
        message = "unauthenticated".tr();
      }
    }

    return Center(
      child: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            PrimaryButton(
                width: 100,
                height: 55,
                onPressed: () {
                  onRetry();
                },
                child: Text("retry".tr(),textAlign: TextAlign.center,style: TextStyle(
                  fontSize: context.locale.languageCode=='ar'?15:18
                ),)
            )
          ],
        ),
      ),
    );
  }
}
