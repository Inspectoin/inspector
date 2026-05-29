import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataFound extends StatelessWidget {
  final String image;
  final String message;
  final Future Function()? refreshFunction;
  final bool withRefresh;
  const NoDataFound({required this.image, required this.message, super.key, this.refreshFunction,this.withRefresh=true});

  @override
  Widget build(BuildContext context) {
    if(withRefresh)
    return RefreshIndicator(
      onRefresh: this.refreshFunction ?? () async {},
      child: noData(context),
    );

    return noData(context);
  }

  Widget noData(context){
   return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            const SizedBox(height: 30),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }


}
