class EventsModel {
  int? results;
  PaginationResult? paginationResult;
  List<EventsData>? data;

  EventsModel({this.results, this.paginationResult, this.data});

  EventsModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? new PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      data = <EventsData>[];
      json['data'].forEach((v) {
        data!.add(new EventsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results;
    if (this.paginationResult != null) {
      data['paginationResult'] = this.paginationResult!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationResult {
  int? currentPage;
  int? limit;
  int? numberOfPages;

  PaginationResult({this.currentPage, this.limit, this.numberOfPages});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    limit = json['limit'];
    numberOfPages = json['numberOfPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['limit'] = this.limit;
    data['numberOfPages'] = this.numberOfPages;
    return data;
  }
}

class EventsData {
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? ticket;
  int? price;
  int? priceAfterDiscount;
  String? imageCover;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  int? numberofticket;
  int? seatnumber;

  EventsData(
      {this.sId,
        this.title,
        this.slug,
        this.description,
        this.ticket,
        this.price,
        this.priceAfterDiscount,
        this.imageCover,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.numberofticket,
        this.seatnumber});

  EventsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    ticket = json['ticket'];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    imageCover = json['imageCover'];
    images = json['images'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    numberofticket = json['numberofticket'];
    seatnumber = json['seatnumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['ticket'] = this.ticket;
    data['price'] = this.price;
    data['priceAfterDiscount'] = this.priceAfterDiscount;
    data['imageCover'] = this.imageCover;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['numberofticket'] = this.numberofticket;
    data['seatnumber'] = this.seatnumber;
    return data;
  }
}
