import 'package:flutter/cupertino.dart';
import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/models/update_acc_details_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/update_acc_details_repo.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import 'package:rxdart/rxdart.dart';

import '../inherited_widget/inherited_widget.dart';

class UpdateAccountDetailsBLOC {
  late final BehaviorSubject<ApiResponse<UpdateAccountDetailsResponseModel>>
      streamCntrl;
  late final CircularProgressBLOC _circularProgressBLOC;
  late final UpdateAccountDetailsRepo _updateAccountDetailsRepo;

  // GETTERS
  Stream<ApiResponse<UpdateAccountDetailsResponseModel>> get stream =>
      streamCntrl.stream;

  Sink<ApiResponse<UpdateAccountDetailsResponseModel>> get sink =>
      streamCntrl.sink;

  CircularProgressBLOC get indicatorInstance => _circularProgressBLOC;

  // METHODS
  void update(UpdateAccountDetailsModel detailsModel) async {
    _circularProgressBLOC.sink.add(true);

    try {
      final model = await _updateAccountDetailsRepo.update(detailsModel);

      if (model.status == 200)
        sink.add(ApiResponse.completed(model));
      else
        sink.add(ApiResponse.error(model.userMsg));
    } catch (e) {
      sink.add(ApiResponse.error(e.toString()));
    }

    _circularProgressBLOC.sink.add(false);
  }

  void _listen(BuildContext context) {
    streamCntrl.listen(
      (response) {
        if (streamCntrl.hasValue) {
          if (response.status == Status.COMPLETED) {
            ShowToast.toast("Profile updated successfully", context, 4);
            final _getAccountDetailsBLOCProvider =
                GetAccountDetailsBLOCProvider.of(context);

            _getAccountDetailsBLOCProvider.bloc.getAccDetails();

            Pop(context);
            return;
          }

          ShowToast.toast(response.message!, context, 4);
        }
      },
    );
  }

  // CONSTRUCTOR
  UpdateAccountDetailsBLOC(BuildContext context) {
    streamCntrl = BehaviorSubject();
    _circularProgressBLOC = CircularProgressBLOC();
    _updateAccountDetailsRepo = UpdateAccountDetailsRepo();

    _listen(context);
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
    _circularProgressBLOC.dispose();
  }
}
