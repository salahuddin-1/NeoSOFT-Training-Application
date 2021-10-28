import 'package:neosoft_training_application/src/models/get_list_cart_items_model.dart';
import 'package:neosoft_training_application/src/resources/api_base_helper.dart';
import 'package:neosoft_training_application/src/ui/homepage.dart';

class GetListCartItemsRepo {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  final _endPointURL = "cart";

  Future<GetListCartItemsResponse> getListCartItems() async {
    final jsonResponse = await _apiBaseHelper.get(
      _endPointURL,
      headers: {
        "access_token": credentials['accessToken']!,
      },
    );

    return GetListCartItemsResponse.fromJson(jsonResponse);
  }
}
