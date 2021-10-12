import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neosoft_training_application/src/models/login_model.dart';

class LoginAPI {
  static Future<LoginResponseModel> login(LoginModel loginModel) async {
    final url =
        Uri.parse("http://staging.php-dev.in:8844/trainingapp/api/users/login");

    final response = await http.post(
      url,
      body: {
        'email': loginModel.email,
        'password': loginModel.password,
      },
    );

    final statusCode = response.statusCode;
    print(statusCode);

    final model = LoginResponseModel.fromJson(jsonDecode(response.body));

    print(model.message);
    return model;
  }
}
