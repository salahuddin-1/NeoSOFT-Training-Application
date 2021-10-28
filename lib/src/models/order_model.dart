class OrderResponse {
  int? status;
  String? message;
  String? userMsg;

  OrderResponse({
    this.status,
    this.message,
    this.userMsg,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'],
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }
}

// ---------------------- ORDERS LIST RESPONSE ---------------------------------

class OrdersListResponse {
  int? status;
  String? message;
  String? userMsg;
  List<Data>? data;

  OrdersListResponse({
    this.status,
    this.message,
    this.userMsg,
    this.data,
  });

  factory OrdersListResponse.fromJson(Map<String, dynamic> json) {
    final jsonData = json['data'];
    List<Data>? data;

    if (jsonData != null && jsonData.runtimeType != bool) {
      List<dynamic> listMaps = jsonData;

      data = listMaps.map((map) => Data.fromJson(map)).toList();
    }

    return OrdersListResponse(
      status: json['status'],
      message: json['message'],
      userMsg: json['user_msg'],
      data: data,
    );
  }
}

class Data {
  int? id;
  int? cost;
  String? created;

  Data({
    this.id,
    this.cost,
    this.created,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      cost: json['cost'],
      created: json['created'],
    );
  }
}

// ------------------ ORDER DETAIL RESPONSE ------------------------------------

class OrderDetailResponse {
  int? status;
  String? message;
  String? userMsg;
  OrderDetailData? data;

  OrderDetailResponse({
    this.status,
    this.message,
    this.userMsg,
    this.data,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    OrderDetailData? orderDetailData;
    final jsonData = json['data'];

    if (jsonData != null && jsonData.runtimeType != bool) {
      orderDetailData = OrderDetailData.fromJson(jsonData);
    }

    return OrderDetailResponse(
      status: json['status'],
      message: json['message'],
      userMsg: json['user_msg'],
      data: orderDetailData,
    );
  }
}

class OrderDetailData {
  int? id;
  int? cost;
  String? created;
  List<OrderDetails>? orderDetails;

  OrderDetailData({
    this.id,
    this.cost,
    this.created,
    this.orderDetails,
  });

  factory OrderDetailData.fromJson(Map<String, dynamic> json) {
    List<OrderDetails>? orderDetails;
    final jsonData = json['order_details'];

    if (jsonData != null && jsonData.runtimeType != bool) {
      List<dynamic> listMaps = jsonData;

      orderDetails = listMaps.map((map) => OrderDetails.fromJson(map)).toList();
    }
    return OrderDetailData(
      id: json['id'],
      cost: json['cost'],
      created: json['created'],
      orderDetails: orderDetails,
    );
  }
}

class OrderDetails {
  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  int? total;
  String? prodName;
  String? prodCatName;
  String? prodImage;

  OrderDetails({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.total,
    this.prodName,
    this.prodCatName,
    this.prodImage,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    total = json['total'];
    prodName = json['prod_name'];
    prodCatName = json['prod_cat_name'];
    prodImage = json['prod_image'];
  }
}
