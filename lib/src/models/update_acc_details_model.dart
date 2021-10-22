class UpdateAccountDetailsModel {
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? phoneNumber;
  String? profilePic;

  UpdateAccountDetailsModel({
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.phoneNumber,
    this.profilePic,
  });
}

class UpdateAccountDetailsResponseModel {
  int? status;
  Data? data;
  String? message;
  String? userMsg;

  UpdateAccountDetailsResponseModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory UpdateAccountDetailsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    Data? data;

    if (json['data'] != null && json['data'].runtimeType != bool) {
      data = Data.fromJson(json['data']);
    }
    return UpdateAccountDetailsResponseModel(
      status: json['status'],
      message: json['message'],
      userMsg: json['user_msg'],
      data: data,
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

class Data {
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
  String? dob;
  bool? isActive;
  String? created;
  String? modified;
  String? accessToken;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      roleId: json['role_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      profilePic: json['profile_pic'],
      countryId: json['country_id'],
      gender: json['gender'],
      phoneNo: json['phone_no'],
      dob: json['dob'],
      isActive: json['is_active'],
      created: json['created'],
      modified: json['modified'],
      accessToken: json['access_token'],
    );
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
