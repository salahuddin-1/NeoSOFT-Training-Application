import 'package:neosoft_training_application/src/models/set_ratings_model.dart';

import 'api_base_helper.dart';

class SetRatingsRepo {
  ApiBaseHelper _helper = new ApiBaseHelper();
  final String _url = "products/setRating";

  Future<SetRatingsSuccessModel> setRatings({
    required String productId,
    required String rating,
  }) async {
    final response = await _helper.post(
      _url,
      body: {
        "product_id": productId,
        "rating": rating,
      },
    );

    final model = SetRatingsSuccessModel.fromJson(response);
    return model;
  }
}

final data = {
  "status": 200,
  "data": {
    "id": 1,
    "product_category_id": 1,
    "name": "Cool Side Table",
    "producer": "Tabla",
    "description": "",
    "cost": 880,
    "rating": 2,
    "view_count": 5,
    "created": "2015-08-31T13:57:41+0000",
    "modified": "2015-09-03T04:45:18+0000",
    "product_images": ""
  },
  "message": "Rating successful.",
  "user_msg": "Thank you for rating."
};
