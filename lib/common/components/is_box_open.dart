import 'package:hive_flutter/hive_flutter.dart';

Future isBoxOpen(String key) async {
  if (!Hive.isBoxOpen(key)) {
    await Hive.openBox(key);
  }
}
