import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserData {
  static String boxKey = 'user_data';
  @HiveField(0)
  String? token;
  @HiveField(1)
  UserModel? user;

  UserData({this.token, this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  static String boxKey = 'user_model';
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  String? phoneNumber;
  @HiveField(3)
  String? language;
  @HiveField(4)
  String? country;

  UserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.language,
    this.country,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    language = json['language'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['language'] = language;
    data['country'] = country;
    return data;
  }
}
