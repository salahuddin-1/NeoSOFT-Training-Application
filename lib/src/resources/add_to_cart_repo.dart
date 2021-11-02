import 'package:neosoft_training_application/src/models/add_to_cart_model.dart';
import 'package:neosoft_training_application/src/resources/api_base_helper.dart';
import '/src/ui/homescreen/homescreen.dart';

class AddToCartRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  final String _url = "addToCart";

  Future<AddToCartResponse> addToCart(AddtoCartModel addtoCartModel) async {
    final jsonResonse = await _apiBaseHelper.post(
      _url,
      headers: {
        "access_token": credentials['accessToken']!,
      },
      body: {
        "product_id": addtoCartModel.productId,
        "quantity": addtoCartModel.quantity,
      },
    );

    print(jsonResonse);

    return AddToCartResponse.fromJson(jsonResonse);
  }
}
