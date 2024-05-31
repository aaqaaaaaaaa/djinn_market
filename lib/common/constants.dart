import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class AppConstants {
  static const countryBox = 'country_box';



  static var mask = MaskTextInputFormatter(
      mask: '(##) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
}

pushTo(Widget page, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

pop(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
