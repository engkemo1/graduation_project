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
  String? description;
  int? pricePre;
  int? price;
  int? seatnumber;
  List<Null>? seatNumbers;
  String? imageCover;
  String? category;
  String? subcategorie;
  String? from;
  String? to;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? placesLeft;
  int? rate;

  EventsData(
      {this.sId,
        this.title,
        this.description,
        this.pricePre,
        this.price,
        this.seatnumber,
        this.seatNumbers,
        this.imageCover,
        this.category,
        this.subcategorie,
        this.from,
        this.to,
        this.location,
        this.createdAt,
        this.rate,
        this.updatedAt,
        this.placesLeft});

  EventsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    pricePre = json['pricePre'];
    price = json['price'];
    seatnumber = json['seatnumber'];
    if (json['seatNumbers'] != null) {
      seatNumbers = <Null>[];
      json['seatNumbers'].forEach((v) {
        seatNumbers!.add(v);
      });
    }
    imageCover = json['imageCover'];
    category = json['category'];
    subcategorie = json['subcategorie'];
    from = json['from'];
    rate = json['rate'];

    to = json['to'];
    location = json['location'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    placesLeft = json['placesLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rate'] = this.rate;

    data['title'] = this.title;
    data['description'] = this.description;
    data['pricePre'] = this.pricePre;
    data['price'] = this.price;
    data['seatnumber'] = this.seatnumber;
    if (this.seatNumbers != null) {
      data['seatNumbers'] = this.seatNumbers!.map((v) => v).toList();
    }
    data['imageCover'] = this.imageCover;
    data['category'] = this.category;
    data['subcategorie'] = this.subcategorie;
    data['from'] = this.from;
    data['to'] = this.to;
    data['location'] = this.location;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['placesLeft'] = this.placesLeft;
    return data;
  }
}
