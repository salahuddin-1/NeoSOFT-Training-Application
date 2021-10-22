class GetListCartItemsResponse {
  int? status;
  String? message;
  String? userMsg;
  List<Data>? data;
  int? count;
  int? total;

  GetListCartItemsResponse({
    this.status,
    this.data,
    this.count,
    this.total,
    this.message,
    this.userMsg,
  });

  factory GetListCartItemsResponse.fromJson(Map<String, dynamic> json) {
    var jsonData = json['data'];
    List<Data>? data;

    if (jsonData != null && jsonData.runtimeType != bool) {
      List<dynamic> list = json['data'];
      data = list.map((map) => Data.fromJson(map)).toList();
    }

    return GetListCartItemsResponse(
      status: json['status'],
      count: json['count'],
      total: json['total'],
      userMsg: json['user_msg'],
      message: json['message'],
      data: data,
    );
  }
}

class Data {
  int? id;
  int? productId;
  int? quantity;
  Product? product;

  Data({
    this.id,
    this.productId,
    this.quantity,
    this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

class Product {
  int? id;
  String? name;
  int? cost;
  String? productCategory;
  String? productImages;
  int? subTotal;

  Product({
    this.id,
    this.name,
    this.cost,
    this.productCategory,
    this.productImages,
    this.subTotal,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      productCategory: json['product_category'],
      productImages: json['product_images'],
      subTotal: json['sub_total'],
    );
  }
}
