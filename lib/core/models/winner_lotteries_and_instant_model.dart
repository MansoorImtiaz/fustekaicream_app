class MainWinnerLotteriesAndInstantModel {
  bool? success;
  List<LotteriesOrInstant>? lotteriesOrInstant;
  String? message;

  MainWinnerLotteriesAndInstantModel({this.success, this.lotteriesOrInstant, this.message});

  MainWinnerLotteriesAndInstantModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      lotteriesOrInstant = <LotteriesOrInstant>[];
      json['data'].forEach((v) {
        lotteriesOrInstant!.add(LotteriesOrInstant.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (lotteriesOrInstant != null) {
      data['data'] = lotteriesOrInstant!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class LotteriesOrInstant {
  int? id;
  String? userId;
  String? randomNumber;
  String? qrCode;
  String? winningDate;

  LotteriesOrInstant({this.id, this.userId, this.randomNumber,  this.qrCode, this.winningDate});

  LotteriesOrInstant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    randomNumber = json['random_number'];
    qrCode = json['qr_code'];
    winningDate = json['winning_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['random_number'] = randomNumber;
    data['qr_code'] = qrCode;
    data['winning_date'] = winningDate;
    return data;
  }
}