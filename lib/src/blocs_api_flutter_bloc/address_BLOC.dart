import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/save_address_to_local_storage.dart';

class AddressBLOC extends Bloc<Status, ApiResponse<List<String>>> {
  AddressBLOC() : super(ApiResponse.empty()) {
    _saveAddressToLocalStorage = SaveAddressToLocalStorage();
  }

  late final SaveAddressToLocalStorage _saveAddressToLocalStorage;

  @override
  Stream<ApiResponse<List<String>>> mapEventToState(Status event) async* {
    if (event == Status.LOADING) {
      yield ApiResponse.loading('loading');

      try {
        final list = await _saveAddressToLocalStorage.getAddress();
        yield ApiResponse.completed(list);
      } catch (e) {
        yield ApiResponse.error(e.toString());
      }
    }
  }
}
