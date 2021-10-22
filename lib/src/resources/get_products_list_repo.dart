import 'package:neosoft_training_application/src/models/product_list_response_model.dart';

import 'api_base_helper.dart';

class GetProductsListRepo {
  final ApiBaseHelper _helper = new ApiBaseHelper();

  final _url = "products/getList";

  final Map<String, String> productTypes = {
    "tables": "1",
    "chairs": "2",
    "sofas": "3",
    "cupboards": "4",
  };

  Future<ProductListResponseModel> get({required String productType}) async {
    productType = productType.toLowerCase();

    final _queryParameters = {
      'product_category_id': productTypes[productType],
      'limit': '10',
      'page': "1",
    };

    final _query = Uri(queryParameters: _queryParameters).query;

    final _finalURL = _url + "?" + _query;

    final response = await _helper.get(_finalURL);

    return ProductListResponseModel.fromJson(response);
  }
}
