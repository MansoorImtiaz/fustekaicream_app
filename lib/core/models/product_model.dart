class ProductsModel {
  bool? success;
  List<Products?>? products;
  String? message;

  ProductsModel({this.success, this.products, this.message});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      products = <Products>[];
      json['data'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (products != null) {
      data['data'] = products!.map((v) => v!.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? categoryId;
  String? parentId;
  String? transId;
  String? image;
  String? price;
  String? productSize;
  String? sku;
  String? nutritionalInfo;
  String? description;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.id,
        this.title,
        this.categoryId,
        this.parentId,
        this.transId,
        this.image,
        this.price,
        this.productSize,
        this.sku,
        this.nutritionalInfo,
        this.description,
        this.createdAt,
        this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    parentId = json['parent_id'];
    transId = json['trans_id'];
    image = json['image'];
    price = json['price'];
    productSize = json['product_size'];
    sku = json['sku'];
    nutritionalInfo = json['nutritional_info'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category_id'] = categoryId;
    data['parent_id'] = parentId;
    data['trans_id'] = transId;
    data['image'] = image;
    data['price'] = price;
    data['product_size'] = productSize;
    data['sku'] = sku;
    data['nutritional_info'] = nutritionalInfo;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}