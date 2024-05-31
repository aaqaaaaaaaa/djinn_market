import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.radius,
    this.height,
    this.icon,
    this.textStyle,
    this.width,
    this.color,
    this.border,
    this.replaceTextVSIcon = false,
  });
  final Function()? onPressed;
  final String text;
  final double? radius;
  final double? height;
  final double? width;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? color;
  final BoxBorder? border;
  final bool? replaceTextVSIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 46.h),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 7.r))),
      child: Ink(
        decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(radius ?? 7.r)),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 46.h,
          alignment: Alignment.center,
          child: replaceTextVSIcon == false
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: textStyle ??
                          AppTextStyles.body20w4
                              .copyWith(color: AppColors.white),
                    ),
                    SizedBox(width: 4.w),
                    icon ?? const SizedBox.shrink(),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon ?? const SizedBox.shrink(),
                    SizedBox(width: 4.w),
                    Text(
                      text,
                      style: textStyle ??
                          AppTextStyles.body20w4
                              .copyWith(color: AppColors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
