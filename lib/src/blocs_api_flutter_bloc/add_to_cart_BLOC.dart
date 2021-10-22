import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/resources/add_to_cart_repo.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';

class AddToCartBLOC extends Bloc<Status, ApiResponse> {
  final AddToCartRepo addToCartRepo;

  AddToCartBLOC({
    required this.addToCartRepo,
  }) : super(ApiResponse.empty());

  @override
  Stream<ApiResponse> mapEventToState(Status status) async* {
    if (status == Status.LOADING) {
      yield ApiResponse.loading('loading');

      try {
        // final model = await addToCartRepo.addToCart();
        // yield ApiResponse.completed(model);
      } catch (e) {
        yield ApiResponse.error(e.toString());
      }
    }
  }
}
