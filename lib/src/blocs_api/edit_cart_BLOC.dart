import 'package:flutter/cupertino.dart';
import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/models/edit_cart_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/edit_cart_repo.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import 'package:rxdart/rxdart.dart';

class EditCartBLOC {
  // INITIALIZERS
  late final BehaviorSubject<ApiResponse<EditCartResponse>> streamCntrl;
  late EditCartRepo _editCartRepo;
  late CircularProgressBLOC _circularProgressBLOC;
  late BuildContext _context;

  Stream<ApiResponse<EditCartResponse>> get stream => streamCntrl.stream;
  CircularProgressBLOC get loadingInstance => _circularProgressBLOC;

  void editCart(EditCartModel editCartModel) async {
    _circularProgressBLOC.sink.add(true);

    try {
      final response = await _editCartRepo.editCart(editCartModel);

      if (response.status == 200) {
        streamCntrl.add(ApiResponse.completed(response));
      } else {
        streamCntrl.add(ApiResponse.error(response.userMsg));
      }
    } catch (e) {
      streamCntrl.add(ApiResponse.error(e.toString()));
    }

    _circularProgressBLOC.sink.add(false);
  }

  listen() {
    streamCntrl.listen(
      (response) {
        if (response.status == Status.COMPLETED) {
          ShowToast.toast(response.data!.userMsg!, _context, 4);
          Pop(_context);
        } else if (response.status == Status.ERROR) {
          ShowToast.toast(response.message!, _context, 4);
        }
      },
    );
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
    _circularProgressBLOC.dispose();
  }

  // CONSTRCTOR
  EditCartBLOC(BuildContext context) {
    streamCntrl = BehaviorSubject();
    _editCartRepo = EditCartRepo();
    _circularProgressBLOC = CircularProgressBLOC();
    this._context = context;

    listen();
  }
}
