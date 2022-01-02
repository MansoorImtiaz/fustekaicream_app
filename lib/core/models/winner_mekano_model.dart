class MainWinnerMekanoModel {
  bool? success;
  List<WinnerMekano>? winnerMekano;
  String? message;

  MainWinnerMekanoModel({this.success, this.winnerMekano, this.message});

  MainWinnerMekanoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      winnerMekano = <WinnerMekano>[];
      json['data'].forEach((v) {
        winnerMekano!.add(WinnerMekano.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (winnerMekano != null) {
      data['data'] = winnerMekano!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class WinnerMekano {
  int? id;
  String? userId;
  String? image;
  String? winningDate;
  String? winningStatus;

  WinnerMekano({this.id, this.userId, this.image, this.winningDate, this.winningStatus});

  WinnerMekano.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    winningDate = json['winning_date'];
    winningStatus = json['winning_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['winning_date'] = winningDate;
    data['winning_status'] = winningStatus;
    return data;
  }
}