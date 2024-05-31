class CarouselBannersModel {
  int? id;
  String? image;
  String? top;
  String? name;
  String? createdAt;

  CarouselBannersModel(
      {this.id, this.image, this.top, this.name, this.createdAt});

  CarouselBannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    top = json['top'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['top'] = top;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}
