class ProductDetailsResponseModel {
  int? status;
  _Data? data;
  String? message;
  String? userMsg;

  ProductDetailsResponseModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  factory ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    _Data? data;

    if (json['data'] != null && json['data'].runtimeType != bool) {
      data = _Data.fromJson(json['data']);
    }

    return ProductDetailsResponseModel(
      status: json['status'],
      data: data,
      message: json['message'],
      userMsg: json['user_msg'],
    );
  }
}

class _Data {
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
  List<_ProductImages>? productImages;

  _Data({
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

  factory _Data.fromJson(Map<String, dynamic> json) {
    List<dynamic> productImagesJSON = json['product_images'];

    final productImages = productImagesJSON
        .map(
          (map) => _ProductImages.fromJson(map),
        )
        .toList();

    return _Data(
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
      productImages: productImages,
    );
  }
}

class _ProductImages {
  int? id;
  int? productId;
  String? image;
  String? created;
  String? modified;

  _ProductImages({
    this.id,
    this.productId,
    this.image,
    this.created,
    this.modified,
  });

  factory _ProductImages.fromJson(Map<String, dynamic> json) {
    return _ProductImages(
      id: json['id'],
      productId: json['product_id'],
      image: json['image'],
      created: json['created'],
      modified: json['modified'],
    );
  }
}
