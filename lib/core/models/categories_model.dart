class CategoriesModel {
  bool? success;
  List<Categories>? categories;
  String? message;

  CategoriesModel({this.success, this.categories, this.message});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      categories = <Categories>[];
      json['data'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (categories != null) {
      data['data'] = categories!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Categories {
  int? id;
  String? transId;
  String? title;
  String? catImage;
  String? description;
  String? colorCode;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.transId,
        this.title,
        this.catImage,
        this.description,
        this.colorCode,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transId = json['trans_id'];
    title = json['title'];
    catImage = json['cat_image'];
    description = json['description'];
    colorCode = json['color_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trans_id'] = transId;
    data['title'] = title;
    data['cat_image'] = catImage;
    data['description'] = description;
    data['color_code'] = colorCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}