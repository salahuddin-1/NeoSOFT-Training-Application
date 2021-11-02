import 'package:neosoft_training_application/src/models/reset_password_model.dart';
import '/src/ui/homescreen/homescreen.dart';
import 'api_base_helper.dart';

class ResetPasswordRepo {
  ApiBaseHelper _helper = new ApiBaseHelper();
  final String _url = "users/change";

  Future<ResetPasswordResponse> resetPassword(
    ResetPasswordModel resetPasswordModel,
  ) async {
    var response = await _helper.post(
      _url,
      body: {
        "old_password": resetPasswordModel.currentPassword,
        "password": resetPasswordModel.newPassword,
        "confirm_password": resetPasswordModel.confNewPass,
      },
      headers: {
        "access_token": credentials['accessToken']!,
      },
    );

    return ResetPasswordResponse.fromJson(response);
  }
}
