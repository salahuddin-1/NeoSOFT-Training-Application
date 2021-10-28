import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neosoft_training_application/src/models/order_model.dart';
import 'package:neosoft_training_application/src/resources/api_reponse_generic.dart';
import 'package:neosoft_training_application/src/resources/orders_repo.dart';

class OrderBLOC extends Bloc<Status, ApiResponse<OrderResponse>> {
  final OrderRepo _orderRepo = OrderRepo();
  final String address;

  OrderBLOC(this.address) : super(ApiResponse.empty());

  @override
  Stream<ApiResponse<OrderResponse>> mapEventToState(Status event) async* {
    if (event == Status.LOADING) {
      yield ApiResponse.loading('Loading');

      try {
        final model = await _orderRepo.order(address);

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

// --------------------- ORDER LIST BLOC ---------------------------------------

class OrdersListBLOC extends Bloc<Status, ApiResponse<OrdersListResponse>> {
  OrdersListBLOC() : super(ApiResponse.empty()) {
    _ordersListRepo = OrdersListRepo();
  }

  late OrdersListRepo _ordersListRepo;

  @override
  Stream<ApiResponse<OrdersListResponse>> mapEventToState(
    Status event,
  ) async* {
    if (event == Status.LOADING) {
      yield ApiResponse.loading('loading');

      try {
        final model = await _ordersListRepo.getOrdersList();

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

// ------------------------ ORDER DETAIL BLOC ----------------------------------

class OrderDetailBLOC extends Bloc<Status, ApiResponse<OrderDetailResponse>> {
  OrderDetailBLOC(this.orderId) : super(ApiResponse.empty()) {
    _orderDetailRepo = OrderDetailRepo();
  }

  late OrderDetailRepo _orderDetailRepo;
  String orderId;

  @override
  Stream<ApiResponse<OrderDetailResponse>> mapEventToState(
    Status event,
  ) async* {
    if (event == Status.LOADING) {
      yield ApiResponse.loading('loading');

      try {
        final model = await _orderDetailRepo.getOrderDetail(orderId);
        if (model.status == 200) {
          yield ApiResponse.completed(model);
        } else {
          yield ApiResponse.error('error');
        }
      } catch (e) {
        yield ApiResponse.error('error');
      }
    }
  }
}
