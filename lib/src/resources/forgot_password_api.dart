import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neosoft_training_application/src/models/forgot_password_model.dart';

class ForgotPasswordApi {
  Future<ForgotPasswordResponseModel> forgotPassword(String email) async {
    final url = Uri.parse(
      'http://staging.php-dev.in:8844/trainingapp/api/users/forgot',
    );

    final response = await http.post(
      url,
      body: {
        'email': email,
      },
    );

    print(response.statusCode);
    print(response.body);

    final json = jsonDecode(response.body);

    return ForgotPasswordResponseModel.fromJson(json);
  }
}
