import 'package:neosoft_training_application/src/models/product_details_response_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/get_product_details_repo.dart';
import 'package:rxdart/subjects.dart';

class GetProductDetailsBLOC {
  // INITIALIZERS
  late final GetProductDetailsRepo _getProductDetailsRepo;
  late final BehaviorSubject<ApiResponse<ProductDetailsResponseModel>>
      streamCntrl;
  String? _productId;

  // GETTERS
  Stream<ApiResponse<ProductDetailsResponseModel>> get stream =>
      streamCntrl.stream;

  // METHODS
  Future<void> getDetails() async {
    streamCntrl.add(ApiResponse.loading("Loading"));

    try {
      final responseModel = await _getProductDetailsRepo.get(_productId!);

      if (responseModel.status == 200) {
        streamCntrl.add(
          ApiResponse.completed(responseModel),
        );

        return;
      }

      streamCntrl.add(
        ApiResponse.error(responseModel.userMsg),
      );
    } catch (e) {
      streamCntrl.add(
        ApiResponse.error(e.toString()),
      );
    }
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
  }

  // CONSTRUCTOR
  GetProductDetailsBLOC(String productId) {
    _getProductDetailsRepo = GetProductDetailsRepo();
    streamCntrl = BehaviorSubject();
    this._productId = productId;

    getDetails();
  }
}
