class ForgotPasswordResponseModel {
  int? status;
  String? message;
  String? userMsg;

  ForgotPasswordResponseModel({
    this.status,
    this.message,
    this.userMsg,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      status: json['status'],
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}
