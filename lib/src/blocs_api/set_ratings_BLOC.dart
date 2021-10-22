import 'package:flutter/cupertino.dart';
import 'package:neosoft_training_application/src/models/set_ratings_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/set_ratings_repo.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import 'package:rxdart/rxdart.dart';

class SetRatingBLOC {
  // INITIALIZERS
  late BehaviorSubject<ApiResponse<SetRatingsSuccessModel>> streamCntrl;
  late SetRatingsRepo _setRatingsRepo;

  // METHODS
  setRatings({
    required String productId,
    required String rating,
  }) async {
    try {
      final response = await _setRatingsRepo.setRatings(
        productId: productId,
        rating: rating,
      );

      if (response.status == 200) {
        streamCntrl.add(ApiResponse.completed(response));
        return;
      }

      streamCntrl.add(ApiResponse.error(response.userMsg));
    } catch (e) {
      streamCntrl.add(ApiResponse.error(e.toString()));
    }
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
  }

  void listen(BuildContext context) {
    streamCntrl.listen(
      (response) {
        if (response.status == Status.COMPLETED) {
          ShowToast.toast(response.data!.userMsg!, context, 4);
          Pop(context);
        } else {
          ShowToast.toast(response.data!.userMsg!, context, 4);
        }
      },
    );
  }

  // CONSTRUCTOR
  SetRatingBLOC(BuildContext context) {
    streamCntrl = BehaviorSubject();
    _setRatingsRepo = SetRatingsRepo();

    listen(context);
  }
}
