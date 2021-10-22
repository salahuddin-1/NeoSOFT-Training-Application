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

final data = {
  "status": 200,
  "data": [
    {
      "id": 12628,
      "product_id": 3,
      "quantity": 8,
      "product": {
        "id": 3,
        "name": "Vishwakarma",
        "cost": 3333,
        "product_category": "Table",
        "product_images": "",
        "sub_total": 26664
      }
    },
    {
      "id": 12629,
      "product_id": 1,
      "quantity": 8,
      "product": {
        "id": 1,
        "name": "Centre",
        "cost": 5000,
        "product_category": "Table",
        "product_images": "",
        "sub_total": 40000
      }
    },
    {
      "id": 12630,
      "product_id": 2,
      "quantity": 3,
      "product": {
        "id": 2,
        "name": "",
        "cost": 6666,
        "product_category": "Table",
        "product_images": "",
        "sub_total": 19998
      }
    }
  ],
  "count": 3,
  "total": 86662
};
