import 'package:flutter/material.dart';

class IntoTabWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final double? fontSize;
  final double? iconSize;
  const IntoTabWidget({required this.title, this.icon, this.fontSize,this.iconSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(

      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size:iconSize?? 18,
              ),
              const SizedBox(width: 2),
            ],
            Text(
              title,
              style: TextStyle(fontSize: fontSize),
            )
          ],
        ),
      ),
    );
  }
}
