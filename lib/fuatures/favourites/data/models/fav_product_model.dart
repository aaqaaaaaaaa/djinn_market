class FavProductModel {
  int? id;
  String? nameUz;
  String? nameRu;
  String? image;
  String? compressImage;
  int? price;
  String? ball;
  String? createdAt;
  int? user;
  int? product;

  FavProductModel(
      {this.id,
      this.nameUz,
      this.nameRu,
      this.image,
      this.compressImage,
      this.price,
      this.ball,
      this.createdAt,
      this.user,
      this.product});

  FavProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    image = json['image'];
    compressImage = json['compress_image'];
    price = json['price'];
    ball = json['ball'];
    createdAt = json['created_at'];
    user = json['user'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_uz'] = nameUz;
    data['name_ru'] = nameRu;
    data['image'] = image;
    data['compress_image'] = compressImage;
    data['price'] = price;
    data['ball'] = ball;
    data['created_at'] = createdAt;
    data['user'] = user;
    data['product'] = product;
    return data;
  }
}
