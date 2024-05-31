// extension PhoneFormatter on String {
//   String get phone {
//     var code = substring(0, 2);
//     var h = substring(2, 5);
//     var s = substring(5, 7);
//     var t = substring(7);
//     return '+998 ($code) $h - $s - $t';
//   }
// }

import 'package:intl/intl.dart';

extension PhoneFormatter on String {
  String get phone {
    var plus = substring(0, 4);
    var code = substring(4, 6);
    var h = substring(6, 9);
    var s = substring(9, 11);
    var t = substring(11);
    return '$plus ($code) $h $s $t';
  }
}

extension NumberFormatter on String {
  String formatAsNumber() {
    final number = num.tryParse(replaceAll(' ', ''));
    if (number != null) {
      final formatter = NumberFormat('#,##0');
      return formatter.format(number).replaceAll(',', ' ');
    }
    return this;
  }
}

extension NumFormatter on num {
  String formatAsNum() {
    final number = this;
    final formatter = NumberFormat('#,##0');
    return formatter.format(number).replaceAll(',', ' ');
  }
}
