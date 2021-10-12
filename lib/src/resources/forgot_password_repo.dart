import 'package:neosoft_training_application/src/models/forgot_password_model.dart';
import 'package:neosoft_training_application/src/resources/api_base_helper.dart';

class ForgotPasswordRepository {
  ApiBaseHelper _helper = new ApiBaseHelper();

  Future<ForgotPasswordResponseModel> forgotPassword(String email) async {
    final response = await _helper.post(
      "users/forgot",
      body: {
        "email": email,
      },
    );

    return ForgotPasswordResponseModel.fromJson(response);
  }
}
