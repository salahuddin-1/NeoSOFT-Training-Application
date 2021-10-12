import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/shared_pref.dart';
import 'package:neosoft_training_application/src/ui/login/login.dart';

class LogOut {
  static logout() {
    SharedPref.clear();
  }
}
