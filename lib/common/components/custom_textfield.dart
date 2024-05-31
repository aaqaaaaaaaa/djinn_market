import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.leading,
    this.height,
    this.onTap,
    this.radius,
    this.onSubmitted,
    this.textInputType,
    this.inputFormatters,
    this.onChanged,
    this.backgroundColor,
    this.style,
    this.contentPadding,
    this.hintStyle,
    this.borderColor,
    this.maxLines,
    this.isPassword = false,
    this.readOnly,
    this.errorText,
    this.textInputAction,
    this.trailing,
    this.validator,
    this.minLines,
    this.textCalitalization,
  });

  final bool? readOnly;
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? style, hintStyle;
  final String? errorText;
  final Widget? leading, trailing;
  final double? radius, height;
  final int? maxLines, minLines;
  final Color? backgroundColor, borderColor;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isPassword;
  final TextCapitalization? textCalitalization;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        readOnly: widget.readOnly ?? false,
        cursorColor: AppColors.black,
        obscureText: widget.isPassword == true ? isHide : false,
        obscuringCharacter: '*',
        onTap: widget.onTap,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        style: widget.style ?? AppTextStyles.body16w4,
        controller: widget.controller,
        onFieldSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        textCapitalization:
            widget.textCalitalization ?? TextCapitalization.sentences,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.textInputType,
        validator: widget.validator,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentPadding ?? EdgeInsets.all(10.h),
          prefixIconConstraints:
              BoxConstraints(minWidth: 20.h, minHeight: 20.h),
          prefixIcon: widget.leading,
          suffixIconConstraints:
              BoxConstraints(minWidth: 20.h, minHeight: 20.h),
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  icon: Icon(
                    isHide ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.black.withOpacity(.25),
                  ),
                  onPressed: () {
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                )
              : widget.trailing,
          errorText: widget.errorText,
          errorMaxLines: 3,
          filled: true,
          fillColor: widget.backgroundColor ?? Colors.white,
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red, width: 1),
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red, width: 1),
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.black),
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.black),
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor ?? Colors.black),
              borderRadius: BorderRadius.circular(widget.radius ?? 20.r)),
          border: InputBorder.none,
          hintStyle: widget.hintStyle ??
              AppTextStyles.body16w4.copyWith(color: AppColors.grey1),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
