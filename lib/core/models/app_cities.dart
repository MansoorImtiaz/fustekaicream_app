class MainCitiesModel {
  bool? success;
  List<Cities>? cities;
  String? message;

  MainCitiesModel({this.success, this.cities, this.message});

  MainCitiesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      cities = <Cities>[];
      json['data'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (cities != null) {
      data['data'] = cities!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Cities {
  int? id;
  String? cityName;
  String? countryId;
  int? publish;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? modified;
  String? transId;
  String? transStatus;
  String? langName;

  Cities(
      {this.id,
        this.cityName,
        this.countryId,
        this.publish,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.modified,
        this.transId,
        this.transStatus,
        this.langName});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    countryId = json['country_id'];
    publish = json['publish'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    modified = json['modified'];
    transId = json['trans_id'];
    transStatus = json['trans_status'];
    langName = json['lang_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_name'] = cityName;
    data['country_id'] = countryId;
    data['publish'] = publish;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['modified'] = modified;
    data['trans_id'] = transId;
    data['trans_status'] = transStatus;
    data['lang_name'] = langName;
    return data;
  }
}

class LocalCitiesModel{
  String? transId;
  String? cityName;

  LocalCitiesModel({this.transId, this.cityName});
}