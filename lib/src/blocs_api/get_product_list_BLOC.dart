import 'package:neosoft_training_application/src/models/product_list_response_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/get_products_list_repo.dart';
import 'package:rxdart/rxdart.dart';

class GetProductListBLOC {
  late final BehaviorSubject<ApiResponse<ProductListResponseModel>> streamCntrl;
  late final GetProductsListRepo _getProductsListRepo;
  String? productType;

  Stream<ApiResponse<ProductListResponseModel>> get stream =>
      streamCntrl.stream;

  // METHODS
  Future<void> getProducts() async {
    streamCntrl.add(ApiResponse.loading("Loading"));

    try {
      final model = await _getProductsListRepo.get(productType: productType!);

      if (model.status == 200) {
        streamCntrl.add(ApiResponse.completed(model));
        return;
      }

      streamCntrl.add(ApiResponse.error(model.userMsg));
    } catch (e) {
      streamCntrl.add(ApiResponse.error(e.toString()));
    }
  }

  // DISPOSE
  void dispose() {
    streamCntrl.close();
  }

  // CONSTRUCTOR
  GetProductListBLOC(String productType) {
    streamCntrl = BehaviorSubject();
    _getProductsListRepo = GetProductsListRepo();

    this.productType = productType;

    getProducts();
  }
}
