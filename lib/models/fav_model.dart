class FavModel {
  String? status;
  int? results;
  List<FavData>? data;

  FavModel({this.status, this.results, this.data});

  FavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data!.add(new FavData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavData {
  String? sId;
  String? title;
  int? price;
  String? imageCover;
  String? from;
  String? to;

  FavData({this.sId, this.title, this.price, this.imageCover, this.from, this.to});

  FavData.fromJson(Map<String, dynamic> json) {
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
