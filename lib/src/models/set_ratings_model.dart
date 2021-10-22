class SetRatingsSuccessModel {
  int? status;
  Data? data;
  String? message;
  String? userMsg;

  SetRatingsSuccessModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory SetRatingsSuccessModel.fromJson(Map<String, dynamic> json) {
    var data = json['data'];

    if (data != null && data.runtimeType != bool) {
      data = Data.fromJson(json);
    }

    return SetRatingsSuccessModel(
      status: json['status'],
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }
}

class Data {
  int? id;
  int? productCategoryId;
  String? name;
  String? producer;
  String? description;
  int? cost;
  int? rating;
  int? viewCount;
  String? created;
  String? modified;
  String? productImages;

  Data({
    this.id,
    this.productCategoryId,
    this.name,
    this.producer,
    this.description,
    this.cost,
    this.rating,
    this.viewCount,
    this.created,
    this.modified,
    this.productImages,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      productCategoryId: json['product_category_id'],
      name: json['name'],
      producer: json['producer'],
      description: json['description'],
      cost: json['cost'],
      rating: json['rating'],
      viewCount: json['view_count'],
      created: json['created'],
      modified: json['modified'],
      productImages: json['product_images'],
    );
  }
}
