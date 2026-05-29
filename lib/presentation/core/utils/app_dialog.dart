import 'package:flutter/material.dart';

class AppDialog {
  static Future show(context, Widget child) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "barrierLabel",
      pageBuilder: (ctx, a1, a2) {
        return child;
      },
      transitionBuilder: (ctx, a1, a2, child) {
        double curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            content: ClipRRect(borderRadius: BorderRadius.circular(10), child: child),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
