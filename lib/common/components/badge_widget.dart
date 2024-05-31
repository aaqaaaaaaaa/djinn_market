import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BadgeWidget extends StatelessWidget {
  final Widget child;
  final String? value;
  final double badgeRadius;
  final double? fontSize;
  final double? paddingH;
  final double? position;

  const BadgeWidget({
    super.key,
    required this.child,
    this.value,
    this.paddingH,
    this.position,
    this.fontSize,
    this.badgeRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: <Widget>[
        child,
        if (value != null)
          Positioned(
            right: position ?? -5.w,
            top: position ?? -5.h,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: paddingH ?? 8.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppColors.orange,
                border: Border.all(
                  color: AppColors.white,
                  width: 2.w,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius:
                    BorderRadius.circular(badgeRadius), // Применяем радиус
              ),
              child: Text(value ?? '',
                  style: AppTextStyles.body13w4
                      .copyWith(color: AppColors.white, fontSize: fontSize)),
            ),
          ),
      ],
    );
  }
}
