import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';

LinearGradient gradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [DarkRed, Red, DarkRed],
  );
}
