class SubCategoriesModel {
  bool? success;
  List<SubCategories>? subCategories;
  String? message;

  SubCategoriesModel({this.success, this.subCategories, this.message});

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      subCategories = <SubCategories>[];
      json['data'].forEach((v) {
        subCategories!.add(SubCategories.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (subCategories != null) {
      data['data'] = subCategories!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class SubCategories {
  int? id;
  String? transId;
  String? title;
  String? catImage;
  String? description;

  SubCategories({this.id, this.transId, this.title, this.catImage, this.description});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transId = json['trans_id'];
    title = json['title'];
    catImage = json['cat_image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trans_id'] = transId;
    data['title'] = title;
    data['cat_image'] = catImage;
    data['description'] = description;
    return data;
  }
}