import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

class CircularProgressCustom extends StatelessWidget {
  const CircularProgressCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 6.w,
      width: 6.w,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Red,
      ),
    );
  }
}
