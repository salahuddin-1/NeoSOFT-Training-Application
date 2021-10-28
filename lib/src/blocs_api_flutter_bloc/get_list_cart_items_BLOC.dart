import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/models/get_list_cart_items_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/get_list_cart_items_repo.dart';

class GetListCartItemsBLOC
    //            input               output
    extends Bloc<Status, ApiResponse<GetListCartItemsResponse>> {
  // CONSTRUCTOR
  GetListCartItemsBLOC()
      : super(
          ApiResponse.empty(),
        );

  late GetListCartItemsRepo _getListCartItemsRepo = GetListCartItemsRepo();

  @override
  Stream<ApiResponse<GetListCartItemsResponse>> mapEventToState(
    Status event,
  ) async* {
    if (event == Status.LOADING) {
      yield ApiResponse.loading('Loading');

      try {
        final model = await _getListCartItemsRepo.getListCartItems();

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
