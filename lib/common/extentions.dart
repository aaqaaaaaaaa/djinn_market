// import 'package:flutter/material.dart';
//
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
extension GetCurrentLanCode on String {
  String? get lanCode =>
      split('').first.toUpperCase() + split('')[1].toUpperCase();
}
