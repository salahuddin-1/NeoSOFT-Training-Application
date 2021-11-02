import 'package:neosoft_training_application/src/models/edit_cart_model.dart';
import 'package:neosoft_training_application/src/resources/api_base_helper.dart';
import '/src/ui/homescreen/homescreen.dart';

class EditCartRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  final _endPointUrl = "editCart";

  Future<EditCartResponse> editCart(EditCartModel editCartModel) async {
    final jsonResponse = await _apiBaseHelper.post(
      _endPointUrl,
      headers: {
        'access_token': credentials['accessToken']!,
      },
      body: {
        "product_id": editCartModel.productId,
        "quantity": editCartModel.quantity,
      },
    );

    return EditCartResponse.fromJson(jsonResponse);
  }
}
