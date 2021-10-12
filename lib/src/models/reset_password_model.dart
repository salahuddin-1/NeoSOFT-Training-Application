class ResetPasswordModel {
  String? currentPassword;
  String? newPassword;
  String? confNewPass;

  ResetPasswordModel({
    this.confNewPass,
    this.currentPassword,
    this.newPassword,
  });
}

class ResetPasswordResponse {
  int? status;
  String? message;
  String? userMsg;

  ResetPasswordResponse({this.status, this.message, this.userMsg});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
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
