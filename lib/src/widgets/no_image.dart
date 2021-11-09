import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';
import 'package:sizer/sizer.dart';

class NoImage extends StatelessWidget {
  const NoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.w,
      width: 33.w,
      decoration: BoxDecoration(
        color: LightGrey,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        child: Text(
          "No profile photo",
          style: TextStyle(
            color: Black,
          ),
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
