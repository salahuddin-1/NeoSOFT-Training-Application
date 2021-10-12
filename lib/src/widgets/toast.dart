import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';

class ShowToast {
  static toast(String msg, BuildContext context, int duration) {
    return showToast(
      msg,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: duration),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: Colors.black87,
      textStyle: TextStyle(
        color: White,
      ),
    );
  }

  static errorToast(String msg, BuildContext context, int duration) {
    return showToast(
      msg,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: duration),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: Colors.redAccent[700],
      textStyle: TextStyle(
        color: White,
      ),
    );
  }

  static successToast(BuildContext context) {
    return ShowToast.toast(
      "Success",
      context,
      3,
    );
  }
}
