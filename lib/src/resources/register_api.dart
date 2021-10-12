import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neosoft_training_application/src/models/user_model.dart';

class RegisterAPI {
  static Future<RegisterResponseModel> registerUser(
    RegisterModel registerModel,
  ) async {
    var url = 'http://staging.php-dev.in:8844/trainingapp/api/users/register';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'first_name': registerModel.firstName,
        'last_name': registerModel.lastName,
        'email': registerModel.email,
        'password': registerModel.password,
        'confirm_password': registerModel.confirmPassword,
        'gender': registerModel.gender,
        'phone_no': registerModel.phoneNo,
      },
    );

    int reponseCode = response.statusCode;
    final json = jsonDecode(response.body);

    if (reponseCode == 200) {
      return RegisterResponseModel.fromJson(json);
    }

    return RegisterResponseModel.fromJsonError(json);
  }
}
