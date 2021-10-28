import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/models/delete_item_from_cart_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/delete_item_from_cart_repo.dart';

class DeleteItemFromCartBLOC
    extends Bloc<Status, ApiResponse<DeleteItemFromCartResponse>> {
  DeleteItemFromCartBLOC(this._productId) : super(ApiResponse.empty());

  final String _productId;

  final _deleteItemFromCartRepo = DeleteItemFromCartRepo();

  @override
  Stream<ApiResponse<DeleteItemFromCartResponse>> mapEventToState(
    Status event,
  ) async* {
    if (event == Status.LOADING) {
      yield ApiResponse.loading('Loading');

      try {
        final model = await _deleteItemFromCartRepo.deleteItem(_productId);

        if (model.status == 200) {
          yield ApiResponse.completed(model);
        } else {
          yield ApiResponse.error(model.userMsg);
        }
      } catch (e) {
        yield ApiResponse.error(e.toString());
      }
    }
  }
}
