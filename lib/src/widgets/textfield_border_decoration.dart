import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/colors.dart';

InputDecoration borderDecoration({
  required IconData icon,
  required String labelText,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: White,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: White,
      ),
    ),
    prefixIcon: Icon(
      icon,
      color: White,
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: White,
      fontWeight: FontWeight.w600,
    ),
  );
}
