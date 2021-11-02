import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/blocs_api_flutter_bloc/get_list_cart_items_BLOC.dart';
import 'package:neosoft_training_application/src/resources/shared_pref.dart';
import 'package:neosoft_training_application/src/ui/homescreen/homescreen.dart';
import 'login/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: SharedPref.getCredentials(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final map = snapshot.data!;

          if (_userExists(map)) {
            return BlocProvider<GetListCartItemsBLOC>(
              create: (context) => GetListCartItemsBLOC(),
              child: HomeScreen(credentials: map),
            );
          }
        }
        return LoginScreen();
      },
    );
  }

  bool _userExists(Map<String, String?> map) {
    return map['email'] != null &&
        map['password'] != null &&
        map['accessToken'] != null;
  }
}
