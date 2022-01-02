class IsValidNumber {
  bool? success;
  String? message;
  String? active;

  IsValidNumber({this.success, this.message, this.active});

  IsValidNumber.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['active'] = active;
    return data;
  }
}