import 'package:http/http.dart' as http;
import '/src/models/reset_password_model.dart';

class ResetPasswordAPI {
  resetPassword(ResetPasswordModel resetPasswordModel) async {
    final url = Uri.parse(
      'http://staging.php-dev.in:8844/trainingapp/api/users/change',
    );

    final response = await http.post(
      url,
      headers: {
        "access_token": "",
      },
      body: {
        "old_password": resetPasswordModel.currentPassword,
        "password": resetPasswordModel.newPassword,
        "confirm_password": resetPasswordModel.confNewPass,
      },
    );

    print(response.statusCode);

    print(response.body);
  }
}
