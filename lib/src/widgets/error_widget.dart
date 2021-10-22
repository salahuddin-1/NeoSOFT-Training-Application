import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ErrorWidgetCustom extends StatelessWidget {
  final String message;
  final Function? onPressed;
  const ErrorWidgetCustom({
    Key? key,
    required this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.message,
            style: TextStyle(color: Black),
          ),
          TextButton(
            onPressed: () => onPressed!(),
            child: Text(
              "Retry",
              style: TextStyle(color: Red),
            ),
          ),
        ],
      ),
    );
  }
}
