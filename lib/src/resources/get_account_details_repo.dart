import 'package:neosoft_training_application/src/models/account_details_model.dart';

import '/src/resources/api_base_helper.dart';
import '/src/ui/homepage.dart';

class GetAccountDetailsRepo {
  final _url = "users/getUserData";
  final ApiBaseHelper _helper = new ApiBaseHelper();

  Future<GetAccountDetailsResponseModel> get() async {
    final response = await _helper.get(
      _url,
      headers: {
        "access_token": credentials['accessToken']!,
      },
    );

    print(response);
    return GetAccountDetailsResponseModel.fromJson(response);
  }
}
