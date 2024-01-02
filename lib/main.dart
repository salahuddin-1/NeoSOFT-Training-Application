import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'src/constants/colors.dart';
import 'src/ui/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NeoSTORE',
          theme: _themeData(),
          home: HomePage(),
        );
      },
    );
  }

  ThemeData _themeData() {
    return ThemeData(
      primaryColor: Red,
      fontFamily: 'Gotham',
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Red,
        centerTitle: true,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Gotham',
            fontSize: 16.sp,
          ),
        ),
        elevation: 0,
      ),
      // primarySwatch: Red,
      // primaryTextTheme: TextTheme(
      //   headline6: TextStyle(
      //     color: Colors.red,
      //   ),
      // ),
    );
  }
}
