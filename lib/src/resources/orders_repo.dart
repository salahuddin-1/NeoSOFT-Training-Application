import 'package:neosoft_training_application/src/models/order_model.dart';
import 'package:neosoft_training_application/src/resources/api_base_helper.dart';
import '/src/ui/homescreen/homescreen.dart';

class OrderRepo {
  final _endPointURL = 'order';
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<OrderResponse> order(String address) async {
    final jsonResponse = await _apiBaseHelper.post(
      _endPointURL,
      headers: {
        'access_token': credentials['accessToken']!,
      },
      body: {
        "address": address,
      },
    );

    return OrderResponse.fromJson(jsonResponse);
  }
}

// ------------- ORDER LIST REPO -----------------------------------------------

class OrdersListRepo {
  final _endPointURL = 'orderList';
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<OrdersListResponse> getOrdersList() async {
    final jsonResponse = await _apiBaseHelper.get(
      _endPointURL,
      headers: {
        'access_token': credentials['accessToken']!,
      },
    );

    return OrdersListResponse.fromJson(jsonResponse);
  }
}

// ------------------- ORDER DETAIL REPO ---------------------------------------

class OrderDetailRepo {
  final _endPointURL = 'orderDetail';
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<OrderDetailResponse> getOrderDetail(String orderId) async {
    final query = Uri(
      queryParameters: {
        'order_id': orderId,
      },
    ).query;

    final finalURL = _endPointURL + '?' + query;

    final jsonResponse = await _apiBaseHelper.get(
      finalURL,
      headers: {
        'access_token': credentials['accessToken']!,
      },
    );

    return OrderDetailResponse.fromJson(jsonResponse);
  }
}
