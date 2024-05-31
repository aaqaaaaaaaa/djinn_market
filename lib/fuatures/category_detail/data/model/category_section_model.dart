class CategorySectionModel {
  int? id;
  String? nameUz;
  String? nameRu;
  bool? isActive;
  String? createdAt;
  int? category;

  CategorySectionModel(
      {this.id,
      this.nameUz,
      this.nameRu,
      this.isActive,
      this.createdAt,
      this.category});

  CategorySectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_uz'] = this.nameUz;
    data['name_ru'] = this.nameRu;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['category'] = this.category;
    return data;
  }
}
