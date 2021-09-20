import 'package:flutter/material.dart';

class IOSarrowIcon extends StatelessWidget {
  final Function onPressed;
  final Color iconColor;
  final double? iconSize;

  const IOSarrowIcon({
    Key? key,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.iconSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        onPressed();
      },
      color: iconColor,
    );
  }
}
