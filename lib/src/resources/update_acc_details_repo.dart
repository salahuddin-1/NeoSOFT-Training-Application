import 'package:neosoft_training_application/src/models/update_acc_details_model.dart';
import '/src/ui/homescreen/homescreen.dart';

import 'api_base_helper.dart';

class UpdateAccountDetailsRepo {
  ApiBaseHelper _helper = new ApiBaseHelper();
  final String _url = "users/update";

  Future<UpdateAccountDetailsResponseModel> update(
      UpdateAccountDetailsModel detailsModel) async {
    print('Post : ' + detailsModel.profilePic!);
    final response = await _helper.post(
      _url,
      body: {
        "first_name": detailsModel.firstName,
        "last_name": detailsModel.lastName,
        "email": detailsModel.email,
        "dob": detailsModel.dob,
        "profile_pic": detailsModel.profilePic,
        "phone_no": detailsModel.phoneNumber,
      },
      headers: {
        "access_token": credentials['accessToken']!,
      },
    );

    return UpdateAccountDetailsResponseModel.fromJson(response);
  }
}
