import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  final double size;

  const Loader({Key? key, this.size = 75.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  CircularProgressIndicator();

  }
}
