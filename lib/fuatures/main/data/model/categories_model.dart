class CategoryModel {
  int? id;
  String? image;
  String? nameUz;
  String? nameRu;
  bool? isActive;
  String? createdAt;
  String? compressImage;

  CategoryModel(
      {this.id,
      this.image,
      this.nameUz,
      this.nameRu,
      this.isActive,
      this.createdAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    compressImage = json['compress_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name_uz'] = nameUz;
    data['name_ru'] = nameRu;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['compress_image'] = compressImage;
    return data;
  }
}
