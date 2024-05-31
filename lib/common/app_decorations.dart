import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppDecorations {
  static BoxDecoration defDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    // color: AppColors.metalColor.shade10,
  );
  static BoxShadow defaultBoxShadow = BoxShadow(
      color: AppColors.shadowColor, offset: Offset(0, 2.w), blurRadius: 4.w);

  static ButtonStyle buttonStyle({
    double? borderRadius,
    Color? bgColor,
    EdgeInsets? padding,
    BorderSide? border,
    Size? size,
  }) {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          side: border ?? BorderSide.none,
        ),
      ),
      fixedSize: MaterialStatePropertyAll(size),
      backgroundColor: MaterialStateProperty.all(bgColor ?? AppColors.white),
      overlayColor: MaterialStateProperty.all(AppColors.black.withOpacity(.2)),
      padding: MaterialStateProperty.all(padding),
    );
  }
}
