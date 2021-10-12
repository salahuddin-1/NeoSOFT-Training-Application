class RegisterModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  String? gender;
  String? phoneNo;

  RegisterModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phoneNo,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}

// --------------------------------------------------------------------------------

class RegisterResponseModel {
  int? status;
  String? message;
  String? userMsg;
  SuccessModel? data;
  ErrorModel? errorModel;

  RegisterResponseModel({
    this.status,
    this.message,
    this.userMsg,
    this.data,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userMsg = json['user_msg'];

    Map<String, dynamic> map = json['data'];

    data = SuccessModel.fromJson(map);
  }

  RegisterResponseModel.fromJsonError(Map<String, dynamic> json) {
    status = json['status'];
    // message = json['message'];
    userMsg = json['user_msg'];

    if (json['data'] != null) {
      Map<String, dynamic> map = json['data'];
      errorModel = ErrorModel.fromJson(map);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['status'] = this.status;
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}

class SuccessModel {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? profilePic;
  String? countryId;
  String? gender;
  String? phoneNo;
  Null dob;
  bool? isActive;
  String? created;
  String? modified;
  String? accessToken;

  SuccessModel({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.profilePic,
    this.countryId,
    this.gender,
    this.phoneNo,
    this.dob,
    this.isActive,
    this.created,
    this.modified,
    this.accessToken,
  });

  SuccessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    profilePic = json['profile_pic'];
    countryId = json['country_id'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
    dob = json['dob'];
    isActive = json['is_active'];
    created = json['created'];
    modified = json['modified'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['profile_pic'] = this.profilePic;
    data['country_id'] = this.countryId;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    data['dob'] = this.dob;
    data['is_active'] = this.isActive;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['access_token'] = this.accessToken;
    return data;
  }
}

class ErrorModel {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phoneNo;

  ErrorModel({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phoneNo,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
