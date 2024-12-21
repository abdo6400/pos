import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ToastMessage on BuildContext {
  void showMessageToast({
    required String msg,
    Toast? toastLength,
    int timeInSecForIosWeb = 1,
    double? fontSize,
    String? fontAsset,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        timeInSecForIosWeb: timeInSecForIosWeb,
        fontSize: fontSize,
        fontAsset: fontAsset,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }

  void showCustomToast({
    required Widget child,
    Widget Function(BuildContext, Widget, ToastGravity?)?
        positionedToastBuilder,
    Duration toastDuration = const Duration(seconds: 2),
    ToastGravity? gravity,
    Duration fadeDuration = const Duration(milliseconds: 350),
    bool isDismissable = false,
  }) {
    FToast fToast = FToast();
    fToast.init(this);
    fToast.showToast(
      child: child,
      positionedToastBuilder: positionedToastBuilder,
      toastDuration: toastDuration,
      fadeDuration: fadeDuration,
      gravity: gravity,
      isDismissible: isDismissable,
    );
  }

  void hideToast() => Fluttertoast.cancel();
}
