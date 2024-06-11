class LoginModel {
  String? status;
  String? token;
  Data? data;

  LoginModel({this.status, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  LoginData? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new LoginData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? sId;
  String? name;
  String? email;
  String? image;

  int? booking;

  List<FavEvent>? favEvent;
  String? role;
  bool? active;
  int? iV;

  LoginData(
      {this.sId,
        this.name,
        this.email,
        this.booking,
        this.favEvent,
        this.role,
        this.active,
        this.iV});

  LoginData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['profileImg'];

    if (json['favEvent'] != null) {
      favEvent = <FavEvent>[];
      json['favEvent'].forEach((v) {
        favEvent!.add(new FavEvent.fromJson(v));
      });
    }
    booking = json['Booking'];

    role = json['role'];
    active = json['active'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Booking'] = this.booking;
data["profileImg"]=this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.favEvent != null) {
      data['favEvent'] = this.favEvent!.map((v) => v.toJson()).toList();
    }
    data['role'] = this.role;
    data['active'] = this.active;
    data['__v'] = this.iV;
    return data;
  }
}

class FavEvent {
  String? sId;
  String? title;
  int? price;
  String? imageCover;
  String? from;
  String? to;

  FavEvent(
      {this.sId, this.title, this.price, this.imageCover, this.from, this.to});

  FavEvent.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    imageCover = json['imageCover'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['imageCover'] = this.imageCover;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
