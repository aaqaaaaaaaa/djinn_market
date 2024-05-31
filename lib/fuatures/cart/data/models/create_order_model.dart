class CreateOrderModel {
  int? userId;
  num? totalPrice;
  String? soldType;
  String? paymentType;
  int? location;
  num? roadPrice;

  CreateOrderModel(
      {this.userId,
      this.totalPrice,
      this.soldType,
      this.paymentType,
      this.roadPrice,
      this.location});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    totalPrice = json['total_price'];
    soldType = json['sold_type'];
    paymentType = json['payment_type'];
    location = json['location'];
    roadPrice = json['road_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['road_price'] = roadPrice;
    data['total_price'] = totalPrice;
    data['sold_type'] = soldType;
    data['payment_type'] = paymentType;
    data['location'] = location;
    return data;
  }
}
