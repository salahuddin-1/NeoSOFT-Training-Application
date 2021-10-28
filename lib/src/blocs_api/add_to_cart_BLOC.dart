import 'package:flutter/cupertino.dart';
import 'package:neosoft_training_application/src/blocs/circular_progress_BLOC.dart';
import 'package:neosoft_training_application/src/models/add_to_cart_model.dart';
import 'package:neosoft_training_application/src/navigation/navigation.dart';
import 'package:neosoft_training_application/src/resources/add_to_cart_repo.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/widgets/toast.dart';
import 'package:rxdart/rxdart.dart';

class AddToCartBLOC {
  // INITIALIZERS
  late final BehaviorSubject<ApiResponse<AddToCartResponse>> streamCntrl;
  late AddToCartRepo _addToCartRepo;
  late CircularProgressBLOC _circularProgressBLOC;
  late BuildContext _context;

  Stream<ApiResponse<AddToCartResponse>> get stream => streamCntrl.stream;
  CircularProgressBLOC get loadingInstance => _circularProgressBLOC;

  void addToCart(AddtoCartModel addtoCartModel) async {
    _circularProgressBLOC.sink.add(true);

    try {
      final response = await _addToCartRepo.addToCart(addtoCartModel);

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
  AddToCartBLOC(BuildContext context) {
    streamCntrl = BehaviorSubject();
    _addToCartRepo = AddToCartRepo();
    _circularProgressBLOC = CircularProgressBLOC();
    this._context = context;

    listen();
  }
}
