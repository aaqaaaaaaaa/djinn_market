import 'dart:math';

import 'package:intl/intl.dart';

import 'package:flutter/services.dart';

extension NumberFormatter on String {
  String formatAsNumber() {
    if (this == '0') {
      return (Random().nextInt(20) * 1000).toString();
    }
    final number = num.tryParse(this);
    if (number != null) {
      final formatter = NumberFormat('#,##0');
      return formatter.format(number).replaceAll(',', ' ');
    }
    return this;
  }
}

extension NumFormatter on num {
  String formatAsNum({int decimalPlaces = 2}) {
    final formatter = NumberFormat.decimalPattern();
    formatter.maximumFractionDigits = decimalPlaces;
    return formatter.format(this).replaceAll(',', ' ');
  }
}

String dateFormatter(DateTime time) {
  String formatterDate = DateFormat('yyyy-MM-dd').format(time);
  return formatterDate;
}

extension DateFormatter on String {
  String formatDate() {
    DateTime dateTime = DateTime.parse(this);
    DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm");
    String output = dateFormat.format(dateTime);
    return output;
  }
}

String endOfLastMonth() {
  var firstDayOfCurrentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  var lastDayOfPreviousMonth =
      firstDayOfCurrentMonth.subtract(const Duration(days: 1));
  return lastDayOfPreviousMonth.toString().formatDateNotHour();
}

extension DateFormatterOnlyDate on String {
  String formatDateNotHour() {
    DateTime dateTime = DateTime.parse(this);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String output = dateFormat.format(dateTime);
    return output;
  }
}

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

class SingleDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regExp = RegExp(r'^\d*\.?\d*$');
    if (newValue.text.contains(',') ||
        newValue.text.contains('-') ||
        newValue.text.contains(' ')) {
      newValue.text.replaceAll(',', '').replaceAll('-', '').replaceAll(' ', '');
      if (newValue.text == '.') {
        return newValue.replaced(const TextRange(start: 0, end: 1), '0.');
      }
      return oldValue;
    }
    if (newValue.text == '.') {
      return newValue.replaced(const TextRange(start: 0, end: 1), '0.');
    }
    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }

    if (newValue.text.split('.').length != 3) {
      return newValue;
    }
    return oldValue;
  }
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String formattedText =
        newValue.text.replaceAll(RegExp(r'\s+'), '').replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]} ',
            );

    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection.copyWith(
        baseOffset: formattedText.length,
        extentOffset: formattedText.length,
      ),
    );
  }
}
