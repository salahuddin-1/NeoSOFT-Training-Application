import 'package:flutter/material.dart';

BuildContext? buildContext;

h(String val, [BuildContext? context]) {
  buildContext = context;
  print(MediaQuery.of(context!).size.height);
}
