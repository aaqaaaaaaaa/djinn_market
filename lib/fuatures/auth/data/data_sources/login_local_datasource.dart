import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthLocalDataSource {

  UserData? getUser();

  bool hasUser();

  Future<bool> setUser(UserData data);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  UserData? getUser() {
    try {
      final box = Hive.box(UserData.boxKey);
      final eventsFromHive = box.get(UserData.boxKey)?.cast<UserData>();
      return eventsFromHive;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> setUser(UserData data) async {
    try {
      final box = Hive.box(UserData.boxKey);
      box.put(UserData.boxKey, data);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool hasUser() {
    final user = Hive.box(UserData.boxKey);
    return user.isNotEmpty ? true : false;
  }
}
