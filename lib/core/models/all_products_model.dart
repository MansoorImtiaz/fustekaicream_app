class MainAllProducts {
  bool? success;
  List<AllProducts>? allproducts;
  String? message;

  MainAllProducts({this.success, this.allproducts, this.message});

  MainAllProducts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      allproducts = <AllProducts>[];
      json['data'].forEach((v) {
        allproducts!.add(AllProducts.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (allproducts != null) {
      data['data'] = allproducts!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class AllProducts {
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
  int? offer;
  String? colorCode;
  String? createdAt;
  String? updatedAt;

  AllProducts(
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
        this.offer,
        this.colorCode,
        this.createdAt,
        this.updatedAt});

  AllProducts.fromJson(Map<String, dynamic> json) {
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
    offer = json['offer'];
    colorCode = json['color_code'];
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
    data['offer'] = offer;
    data['color_code'] = colorCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}