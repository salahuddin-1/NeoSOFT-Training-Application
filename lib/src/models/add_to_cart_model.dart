class AddtoCartModel {
  String? productId;
  String? quantity;

  AddtoCartModel({
    this.productId,
    this.quantity,
  });
}

class AddToCartResponse {
  int? status;
  bool? data;
  int? totalCarts;
  String? message;
  String? userMsg;

  AddToCartResponse({
    this.status,
    this.data,
    this.totalCarts,
    this.message,
    this.userMsg,
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      status: json['status'],
      data: json['data'],
      totalCarts: json['total_carts'],
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }
}
