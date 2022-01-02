class MainSingleProduct {
  bool? success;
  SingleProduct? singleProduct;
  String? message;

  MainSingleProduct({this.success, this.singleProduct, this.message});

  MainSingleProduct.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    singleProduct = json['data'] != null ? SingleProduct.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (singleProduct != null) {
      data['data'] = singleProduct!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class SingleProduct {
  int? id;
  String? transId;
  String? langName;
  String? title;
  String? productSize;
  String? nutritionalInfo;
  String? description;
  List<String>? images;

  SingleProduct(
      {this.id,
        this.transId,
        this.langName,
        this.title,
        this.productSize,
        this.nutritionalInfo,
        this.description,
        this.images});

  SingleProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transId = json['trans_id'];
    langName = json['lang_name'];
    title = json['title'];
    productSize = json['product_size'];
    nutritionalInfo = json['nutritional_info'];
    description = json['description'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trans_id'] = transId;
    data['lang_name'] = langName;
    data['title'] = title;
    data['product_size'] = productSize;
    data['nutritional_info'] = nutritionalInfo;
    data['description'] = description;
    data['images'] = images;
    return data;
  }
}