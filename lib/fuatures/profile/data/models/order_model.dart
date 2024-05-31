class OrderModel {
  int? id;
  List<Products>? products;
  String? phoneNumber;
  num? totalPrice;
  String? type;
  String? soldType;
  String? paymentType;
  String? startTime;
  String? endTime;
  String? status;
  num? roadPrice;
  num? user;
  num? location;

  // Null? deliveryType;
  // Null? deliveryId;

  OrderModel({
    this.id,
    this.products,
    this.phoneNumber,
    this.totalPrice,
    this.type,
    this.soldType,
    this.paymentType,
    this.startTime,
    this.endTime,
    this.status,
    this.roadPrice,
    this.user,
    this.location,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    phoneNumber = json['phone_number'];
    totalPrice = json['total_price'];
    type = json['type'];
    soldType = json['sold_type'];
    paymentType = json['payment_type'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    roadPrice = json['road_price'];
    user = json['user'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['phone_number'] = phoneNumber;
    data['total_price'] = totalPrice;
    data['type'] = type;
    data['sold_type'] = soldType;
    data['payment_type'] = paymentType;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['road_price'] = roadPrice;
    data['user'] = user;
    data['location'] = location;
    return data;
  }
}

class Products {
  int? id;
  String? nameUz;
  String? nameRu;
  String? image;
  num? amount;
  String? convert;
  num? price;

  Products(
      {this.id,
      this.nameUz,
      this.nameRu,
      this.image,
      this.amount,
      this.convert,
      this.price});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    image = json['image'];
    amount = json['amount'];
    convert = json['convert'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_uz'] = nameUz;
    data['name_ru'] = nameRu;
    data['image'] = image;
    data['amount'] = amount;
    data['convert'] = convert;
    data['price'] = price;
    return data;
  }
}
