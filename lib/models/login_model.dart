class loginModel {
  LoginData? data;
  String? token;

  loginModel({this.data, this.token});

  loginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class LoginData {
  String? sId;
  String? name;
  String? email;
  String? role;
  bool? active;
  int? iV;

  LoginData({this.sId, this.name, this.email, this.role, this.active, this.iV});

  LoginData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    active = json['active'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['active'] = this.active;
    data['__v'] = this.iV;
    return data;
  }
}
