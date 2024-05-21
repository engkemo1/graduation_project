class CartModel {
  String? status;
  int? numOfCartItems;
  Data? data;

  CartModel({this.status, this.numOfCartItems, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['numOfCartItems'] = this.numOfCartItems;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  List<CartItems>? cartItems;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? totalCartPrice;

  Data(
      {this.sId,
        this.cartItems,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.totalCartPrice});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['totalCartPrice'] = this.totalCartPrice;
    return data;
  }
}

class CartItems {
  String? event;
  int? quantity;
  int? ticket;
  int? price;
  String? sId;

  CartItems({this.event, this.quantity, this.ticket, this.price, this.sId});

  CartItems.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    quantity = json['quantity'];
    ticket = json['ticket'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['quantity'] = this.quantity;
    data['ticket'] = this.ticket;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}
