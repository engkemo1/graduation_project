class NotificationModel {
  int? results;
  List<NotificationData>? data;

  NotificationModel({this.results, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? sId;
  String? notification;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? user;

  NotificationData(
      {this.sId,
        this.notification,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.user});

  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    notification = json['notification'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['notification'] = this.notification;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['user'] = this.user;
    return data;
  }
}
