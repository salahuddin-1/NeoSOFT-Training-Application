import 'package:neosoft_training_application/src/models/product_details_response_model.dart';

import 'api_base_helper.dart';

class GetProductDetailsRepo {
  final ApiBaseHelper _helper = new ApiBaseHelper();
  final _url = "products/getDetail";

  Future<ProductDetailsResponseModel> get(String productId) async {
    final query = Uri(
      queryParameters: {
        "product_id": productId,
      },
    ).query;

    final finalUrl = _url + '?' + query;

    final response = await _helper.get(finalUrl);

    return ProductDetailsResponseModel.fromJson(response);
  }
}
