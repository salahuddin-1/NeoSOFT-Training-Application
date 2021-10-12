import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/resources/shared_pref.dart';
import 'package:neosoft_training_application/src/ui/homescreen/homescreen.dart';
import 'login/login.dart';

Map<String, String?> credentials = {};

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: SharedPref.getCredentials(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final map = snapshot.data!;

          credentials = map;

          if (map['email'] != null &&
              map['password'] != null &&
              map['accessToken'] != null) {
            return HomeScreen();
          }
        }
        return LoginScreen();
      },
    );
  }
}
