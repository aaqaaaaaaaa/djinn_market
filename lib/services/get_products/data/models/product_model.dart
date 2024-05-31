class GetProductModel {
  int? id;
  String? nameUz;
  String? nameRu;
  String? compressImage;
  String? image;
  num? amount;
  num? price;
  String? convert;
  int? childSection;
  String? descriptionUz;
  String? descriptionRu;
  bool? isFavourite;
  num? discount;

  GetProductModel({
    this.id,
    this.nameUz,
    this.nameRu,
    this.compressImage,
    this.image,
    this.amount,
    this.price,
    this.convert,
    this.childSection,
    this.descriptionUz,
    this.descriptionRu,
    this.isFavourite,
    this.discount,
  });

  GetProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    compressImage = json['compress_image'];
    image = json['image'];
    amount = json['amount'];
    price = json['price'];
    convert = json['convert'];
    childSection = json['child_section'];
    descriptionUz = json['description_uz'];
    descriptionRu = json['description_ru'];
    isFavourite = json['is_favourite'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_uz'] = nameUz;
    data['name_ru'] = nameRu;
    data['compress_image'] = compressImage;
    data['image'] = image;
    data['amount'] = amount;
    data['price'] = price;
    data['convert'] = convert;
    data['child_section'] = childSection;
    data['description_uz'] = descriptionUz;
    data['description_ru'] = descriptionRu;
    data['is_favourite'] = isFavourite;
    data['discount'] = discount;

    return data;
  }
}
