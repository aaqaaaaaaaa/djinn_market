class GetCardModel {
  int? id;
  String? productImage;
  String? productNameUz;
  String? productNameRu;
  int? productPrice;
  // List characteristic;
  int? amount;
  bool? ordered;
  String? createdAt;
  // dynamic order;
  int? product;
  int? user;

  GetCardModel(
      {this.id,
      this.productImage,
      this.productNameUz,
      this.productNameRu,
      this.productPrice,
      // this.characteristic,
      this.amount,
      this.ordered,
      this.createdAt,
      // this.order,
      this.product,
      this.user});

  GetCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImage = json['product_image'];
    productNameUz = json['product_name_uz'];
    productNameRu = json['product_name_ru'];
    productPrice = json['product_price'];
    // if (json['characteristic'] != null) {
    //   characteristic = <Null>[];
    //   json['characteristic'].forEach((v) {
    //     characteristic!.add(new Null.fromJson(v));
    //   });
    // }
    amount = json['amount'];
    ordered = json['ordered'];
    createdAt = json['created_at'];
    // order = json['order'];
    product = json['product'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_image'] = productImage;
    data['product_name_uz'] = productNameUz;
    data['product_name_ru'] = productNameRu;
    data['product_price'] = productPrice;
    // if (characteristic != null) {
    //   data['characteristic'] =
    //       characteristic!.map((v) => v.toJson()).toList();
    // }
    data['amount'] = amount;
    data['ordered'] = ordered;
    data['created_at'] = createdAt;
    // data['order'] = order;
    data['product'] = product;
    data['user'] = user;
    return data;
  }
}
