import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

import 'circular_progress.dart';

class LoginRegisterButton extends StatelessWidget {
  final Function? onPressed;
  final String title;
  final bool isLoading;

  const LoginRegisterButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {
        onPressed!();
      },
      height: 7.h,
      minWidth: double.infinity,
      color: White,
      child: isLoading
          ? CircularProgressCustom()
          : Text(
              title,
              style: TextStyle(
                color: Red,
                fontWeight: FontWeight.w700,
                fontSize: 19.sp,
              ),
            ),
    );
  }
}
