class DeleteItemFromCartResponse {
  int? status;
  bool? data;
  int? totalCarts;
  String? message;
  String? userMsg;

  DeleteItemFromCartResponse({
    this.status,
    this.data,
    this.totalCarts,
    this.message,
    this.userMsg,
  });

  factory DeleteItemFromCartResponse.fromJson(Map<String, dynamic> json) {
    return DeleteItemFromCartResponse(
      status: json['status'],
      data: json['data'],
      totalCarts: json['total_carts'],
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }
}
