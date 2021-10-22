import 'package:neosoft_training_application/src/models/account_details_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/get_account_details_repo.dart';
import 'package:rxdart/rxdart.dart';

class GetAccountDetailsBLOC {
  // DECLARATIONS
  late final BehaviorSubject<ApiResponse<GetAccountDetailsResponseModel>>
      streamCntrl;
  late final GetAccountDetailsRepo _getAccountDetailsRepo;

  // GETTERS
  Stream<ApiResponse<GetAccountDetailsResponseModel>> get stream =>
      streamCntrl.stream;

  Sink<ApiResponse<GetAccountDetailsResponseModel>> get sink =>
      streamCntrl.sink;

  // METHODS
  Future<void> getAccDetails() async {
    sink.add(ApiResponse.loading("Loading"));

    try {
      final model = await _getAccountDetailsRepo.get();

      if (model.status == 200)
        sink.add(ApiResponse.completed(model));
      else
        sink.add(ApiResponse.error(model.userMsg));
    } catch (e) {
      sink.add(ApiResponse.error(e.toString()));
    }
  }

  // CONSTRUCTORS
  GetAccountDetailsBLOC() {
    streamCntrl = BehaviorSubject();
    _getAccountDetailsRepo = GetAccountDetailsRepo();
    getAccDetails();
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
  }
}
