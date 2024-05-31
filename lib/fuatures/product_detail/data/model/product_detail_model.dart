

class ProductDetailModel {
  int? id;
  List<ImageModel>? images;
  String? nameUz;
  String? nameRu;
  String? descriptionUz;
  String? descriptionRu;
  num? top;
  String? image;
  String? measureUnit;
  String? convert;
  num? amount;
  num? price;
  num? priceInput;
  num? discount;
  String? barcode;
  bool? isSave;
  String? createdAt;
  String? updateAt;
  num? brand;
  int? childSection;
  num? warehouse;

  ProductDetailModel({
    this.id,
    this.images,
    this.nameUz,
    this.nameRu,
    this.descriptionUz,
    this.descriptionRu,
    this.top,
    this.image,
    this.measureUnit,
    this.convert,
    this.amount,
    this.price,
    this.priceInput,
    this.discount,
    this.barcode,
    this.isSave,
    this.createdAt,
    this.updateAt,
    this.brand,
    this.childSection,
    this.warehouse,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    descriptionUz = json['description_uz'];
    descriptionRu = json['description_ru'];
    top = json['top'];
    image = json['image'];
    measureUnit = json['measure_unit'];
    convert = json['convert'];
    amount = json['amount'];
    price = json['price'];
    priceInput = json['price_input'];
    discount = json['discount'];
    barcode = json['barcode'];
    isSave = json['is_save'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    brand = json['brand'];
    childSection = json['child_section'];
    warehouse = json['warehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images;
    data['name_uz'] = nameUz;
    data['name_ru'] = nameRu;
    data['description_uz'] = descriptionUz;
    data['description_ru'] = descriptionRu;
    data['top'] = top;
    data['image'] = image;
    data['measure_unit'] = measureUnit;
    data['convert'] = convert;
    data['amount'] = amount;
    data['price'] = price;
    data['price_input'] = priceInput;
    data['discount'] = discount;
    data['barcode'] = barcode;
    data['is_save'] = isSave;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    data['brand'] = brand;
    data['child_section'] = childSection;
    data['warehouse'] = warehouse;
    return data;
  }
}

class ImageModel {
  int? id;
  String? image;
  int? product;

  ImageModel({this.id, this.image, this.product});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['product'] = product;
    return data;
  }
}
