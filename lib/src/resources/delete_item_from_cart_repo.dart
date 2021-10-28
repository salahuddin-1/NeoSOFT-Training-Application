import 'package:neosoft_training_application/src/models/delete_item_from_cart_model.dart';
import 'package:neosoft_training_application/src/resources/api_base_helper.dart';
import 'package:neosoft_training_application/src/ui/homepage.dart';

class DeleteItemFromCartRepo {
  final _endPointURL = "deleteCart";
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<DeleteItemFromCartResponse> deleteItem(String productId) async {
    final jsonResponse = await _apiBaseHelper.post(
      _endPointURL,
      headers: {
        'access_token': credentials['accessToken']!,
      },
      body: {
        'product_id': productId,
      },
    );

    return DeleteItemFromCartResponse.fromJson(jsonResponse);
  }
}
