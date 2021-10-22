class EditCartModel {
  final String productId;
  final String quantity;

  EditCartModel({
    required this.productId,
    required this.quantity,
  });
}

class EditCartResponse {
  int? status;
  bool? data;
  int? totalCarts;
  String? message;
  String? userMsg;

  EditCartResponse({
    this.status,
    this.data,
    this.totalCarts,
    this.message,
    this.userMsg,
  });

  factory EditCartResponse.fromJson(Map<String, dynamic> json) {
    return EditCartResponse(
      status: json['status'],
      data: json['data'],
      totalCarts: json['total_carts'],
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }
}
