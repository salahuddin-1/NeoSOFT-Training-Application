class AccountDetailsModel {}

class GetAccountDetailsResponseModel {
  int? status;
  String? message;
  String? userMsg;
  Data? data;

  GetAccountDetailsResponseModel({
    this.status,
    this.message,
    this.userMsg,
    this.data,
  });

  factory GetAccountDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    Data? data;

    if (json['data'] != null && json['data'].runtimeType != bool) {
      final Map<String, dynamic> dataMap = json['data'];
      data = Data.fromJson(dataMap);
    }

    return GetAccountDetailsResponseModel(
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
  final UserData? userData;
  final List<ProductCategories>? productCategories;

  Data({
    this.userData,
    this.productCategories,
  });

  factory Data.fromJson(Map<String, dynamic> map) {
    final Map<String, dynamic> userDataMap = map["user_data"];

    final userData = UserData.fromJson(userDataMap);

    final List<dynamic> productCategoriesList = map['product_categories'];

    final productCategories = productCategoriesList
        .map(
          (map) => ProductCategories.fromJson(map),
        )
        .toList();

    return Data(
      userData: userData,
      productCategories: productCategories,
    );
  }
}

class UserData {
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

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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

class ProductCategories {
  int? id;
  String? name;
  String? iconImage;
  String? created;
  String? modified;

  ProductCategories({
    this.id,
    this.name,
    this.iconImage,
    this.created,
    this.modified,
  });

  factory ProductCategories.fromJson(Map<String, dynamic> json) {
    return ProductCategories(
      id: json['id'],
      name: json['name'],
      iconImage: json['icon_image'],
      created: json['created'],
      modified: json['modified'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon_image'] = this.iconImage;
    data['created'] = this.created;
    data['modified'] = this.modified;
    return data;
  }
}
