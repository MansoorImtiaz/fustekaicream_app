class MainHomeSliderModel {
  bool? success;
  List<HomeSlider>? homeSlider;
  String? message;

  MainHomeSliderModel({this.success, this.homeSlider, this.message});

  MainHomeSliderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      homeSlider = <HomeSlider>[];
      json['data'].forEach((v) {
        homeSlider!.add(HomeSlider.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (homeSlider != null) {
      data['data'] = homeSlider!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class HomeSlider {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;

  HomeSlider({this.id, this.image, this.createdAt, this.updatedAt});

  HomeSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


class LocalHomeSliderModel{
  int? id;
  String? image;

  LocalHomeSliderModel({this.id, this.image});
}