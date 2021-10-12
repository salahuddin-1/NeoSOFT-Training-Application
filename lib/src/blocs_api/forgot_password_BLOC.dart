import 'dart:async';

import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/models/forgot_password_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/forgot_password_api.dart';
import 'package:neosoft_training_application/src/resources/forgot_password_repo.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordBLOC {
  forgotPassword(String email) {
    ForgotPasswordApi().forgotPassword(email);
  }
}

class ForgotPasswordBLOC1 {
  late ForgotPasswordRepository _forgotPasswordRepository;

  late CircularProgressBLOC _circularProgressBLOC = CircularProgressBLOC();

  late BehaviorSubject<ApiResponse<ForgotPasswordResponseModel>> streamCntrl;

  StreamSink<ApiResponse<ForgotPasswordResponseModel>> get sink =>
      streamCntrl.sink;

  Stream<ApiResponse<ForgotPasswordResponseModel>> get stream =>
      streamCntrl.stream;

  CircularProgressBLOC get indicatorInstance => _circularProgressBLOC;

  void forgotPassword(String email) async {
    _circularProgressBLOC.sink.add(true);

    try {
      final model = await _forgotPasswordRepository.forgotPassword(email);

      if (model.status == 200) {
        sink.add(
          ApiResponse.completed(model),
        );
      }

      sink.add(
        ApiResponse.error(model.userMsg),
      );
    } catch (e) {
      sink.add(
        ApiResponse.error(e.toString()),
      );
      print(e);
    }

    _circularProgressBLOC.sink.add(false);
  }

  ForgotPasswordBLOC1() {
    streamCntrl = BehaviorSubject();
    _forgotPasswordRepository = ForgotPasswordRepository();
  }

  void dispose() {
    streamCntrl.close();
    _circularProgressBLOC.dispose();
  }
}
