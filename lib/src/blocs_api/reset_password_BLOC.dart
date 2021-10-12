import 'dart:async';

import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/models/reset_password_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/reset_password_repo.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordBLOC {
  // DECLARATIONS
  late final BehaviorSubject<ApiResponse<ResetPasswordResponse>> streamCntrl;
  late final CircularProgressBLOC _circularProgressBLOC;
  late final ResetPasswordRepo _resetPasswordRepo;

  // GETTERS
  CircularProgressBLOC get indicatorInstance => _circularProgressBLOC;
  StreamSink<ApiResponse<ResetPasswordResponse>> get sink => streamCntrl.sink;
  Stream<ApiResponse<ResetPasswordResponse>> get stream => streamCntrl.stream;

  // METHODS
  void resetPassword(ResetPasswordModel resetPasswordModel) async {
    _circularProgressBLOC.sink.add(true);

    try {
      final model = await _resetPasswordRepo.resetPassword(resetPasswordModel);

      if (model.status == 200) {
        sink.add(ApiResponse.completed(model));
      } else {
        sink.add(ApiResponse.error(model.userMsg));
      }
    } catch (e) {
      sink.add(ApiResponse.error(e.toString()));
      print(e);
    }

    _circularProgressBLOC.sink.add(false);
  }

  // CONSTRUCTOR
  ResetPasswordBLOC() {
    streamCntrl = BehaviorSubject();
    _circularProgressBLOC = CircularProgressBLOC();
    _resetPasswordRepo = ResetPasswordRepo();
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
    _circularProgressBLOC.dispose();
  }
}
