class ChildSectionModel {
  int? id;
  String? nameUz;
  String? nameRu;
  int? section;
  bool? isActive;
  int? categoryId;
  int? warehouse;

  ChildSectionModel(
      {this.id,
      this.nameUz,
      this.nameRu,
      this.section,
      this.isActive,
      this.categoryId,
      this.warehouse});

  ChildSectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameUz = json['name_uz'];
    nameRu = json['name_ru'];
    section = json['section'];
    isActive = json['is_active'];
    categoryId = json['category_id'];
    warehouse = json['warehouse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_uz'] = nameUz;
    data['name_ru'] = nameRu;
    data['section'] = section;
    data['is_active'] = isActive;
    data['category_id'] = categoryId;
    data['warehouse'] = warehouse;
    return data;
  }
}
