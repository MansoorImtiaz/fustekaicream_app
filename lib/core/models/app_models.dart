class AppMainModel {
  bool? success;
  Data? data;
  String? message;

  AppMainModel({this.success, this.data, this.message});

  AppMainModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}


class LocalUserProfileModel{
  int? id;
  String? token;
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


  LocalUserProfileModel({
      this.id,
      this.token,
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
      this.updatedAt
  });
}