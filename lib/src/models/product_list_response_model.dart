class ProductListResponseModel {
  String? message;
  String? userMsg;
  int? status;
  List<Data>? data;

  ProductListResponseModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? dataList = json['data'];
    List<Data>? data;

    if (dataList != null && dataList.runtimeType != bool) {
      data = dataList.map((e) => Data.fromJson(e)).toList();
    }

    return ProductListResponseModel(
      status: json['status'],
      data: data,
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    return data;
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

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_category_id'] = this.productCategoryId;
    data['name'] = this.name;
    data['producer'] = this.producer;
    data['description'] = this.description;
    data['cost'] = this.cost;
    data['rating'] = this.rating;
    data['view_count'] = this.viewCount;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['product_images'] = this.productImages;
    return data;
  }
}
