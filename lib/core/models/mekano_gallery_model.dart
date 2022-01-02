class MainMekanoGalleryModel {
  bool? success;
  int? totalCount;
  List<GalleryUserRecord>? userList;

  MainMekanoGalleryModel({this.success, this.totalCount, this.userList});

  MainMekanoGalleryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalCount = json['total_count'];
    if (json['data'] != null) {
      userList = <GalleryUserRecord>[];
      json['data'].forEach((v) {
        userList!.add(GalleryUserRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['total_count'] = totalCount;
    if (userList != null) {
      data['data'] = userList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryUserRecord {
  int? id;
  String? userId;
  String? image;
  String? winningDate;
  String? winningStatus;
  UserData? user;

  GalleryUserRecord(
      {this.id,
        this.userId,
        this.image,
        this.winningDate,
        this.winningStatus,
        this.user});

  GalleryUserRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    winningDate = json['winning_date'];
    winningStatus = json['winning_status'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['winning_date'] = winningDate;
    data['winning_status'] = winningStatus;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? email;
  String? firstName;
  String? surName;
  String? dob;
  String? gender;
  String? phone;
  String? country;
  String? city;
  String? location;
  String? ipAddress;
  String? loggedInAt;
  String? loggedOutAt;
  String? createdAt;
  String? updatedAt;
  String? isActive;
  String? roleId;

  UserData(
      {this.id,
        this.email,
        this.firstName,
        this.surName,
        this.dob,
        this.gender,
        this.phone,
        this.country,
        this.city,
        this.location,
        this.ipAddress,
        this.loggedInAt,
        this.loggedOutAt,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.roleId});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    surName = json['sur_name'];
    dob = json['dob'];
    gender = json['gender'];
    phone = json['phone'];
    country = json['country'];
    city = json['city'];
    location = json['location'];
    ipAddress = json['ip_address'];
    loggedInAt = json['logged_in_at'];
    loggedOutAt = json['logged_out_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['sur_name'] = surName;
    data['dob'] = dob;
    data['gender'] = gender;
    data['phone'] = phone;
    data['country'] = country;
    data['city'] = city;
    data['location'] = location;
    data['ip_address'] = ipAddress;
    data['logged_in_at'] = loggedInAt;
    data['logged_out_at'] = loggedOutAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['role_id'] = roleId;
    return data;
  }
}