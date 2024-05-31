import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text = '',
    this.buttonColor,
    this.textColor,
    this.margin,
    this.elevation,
    this.width,
    this.height,
    this.child,
    this.isUnderline,
    this.onPressed,
    this.textStyle,
    this.leadingWidget,
  });

  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final double? elevation;
  final double? width, height;
  final bool? isUnderline;
  final TextStyle? textStyle;
  final Function()? onPressed;
  final Widget? leadingWidget;
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        elevation: elevation,
        minWidth: width ?? MediaQuery.of(context).size.width,
        textTheme: ButtonTheme.of(context).textTheme,
        height: height ?? 46.h,
        color: buttonColor ?? AppColors.orange,
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.r)),
        child: child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textStyle ??
                      AppTextStyles.body15w5.copyWith(
                        color: textColor ?? AppColors.white,
                        decoration: (isUnderline ?? false)
                            ? TextDecoration.underline
                            : null,
                      ),
                ),
                if (leadingWidget != null) leadingWidget!
              ],
            ),
      ),
    );
  }
}
