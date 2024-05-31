// import 'package:bizda_bor/common/app_colors.dart';
// import 'package:bizda_bor/common/app_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     this.hintText,
//     this.hintStyle,
//     this.onChanged,
//     this.style,
//     this.onTap,
//     this.leading,
//     this.size,
//     this.maxLines,
//     this.border,
//     this.radius,
//     this.keyboardType,
//     required this.controller,
//     this.trailing,
//     this.inputFormatters,
//     this.onSubmitted,
//     this.margin,
//     this.height,
//     this.leadingText,
//     this.fillColor,
//     this.padding,
//     this.contentPadding,
//     this.readOnly = false,
//   });
//
//   final String? hintText, leadingText;
//   final EdgeInsets? contentPadding;
//   final TextEditingController controller;
//   final Widget? trailing;
//   final Widget? leading;
//   final double? height;
//   final List<TextInputFormatter>? inputFormatters;
//   final Function(String)? onChanged, onSubmitted;
//   final TextInputType? keyboardType;
//   final int? maxLines;
//   final Size? size;
//   final TextStyle? hintStyle, style;
//   final Color? fillColor;
//   final double? radius;
//   final EdgeInsets? margin, padding;
//   final Function()? onTap;
//   final bool readOnly;
//   final Border? border;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height ?? 50.h,
//       padding: padding ?? EdgeInsets.only(left: 16.w),
//       margin: margin,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius ?? 4.r),
//         border: border,
//         color: fillColor ?? AppColors.lightBlack.withOpacity(0.3),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (leadingText != null)
//             Text(
//               leadingText ?? '',
//               style: style ?? AppTextStyles.body15w4,
//             ),
//           leading ?? const SizedBox.shrink(),
//           Flexible(
//             child: TextField(
//                 onTap: onTap,
//                 onSubmitted: onSubmitted,
//                 readOnly: readOnly,
//                 onChanged: onChanged,
//                 controller: controller,
//                 keyboardType: keyboardType,
//                 inputFormatters: inputFormatters ?? [],
//                 style: AppTextStyles.body15w4,
//                 decoration: InputDecoration(
//                   hintText: hintText,
//                   contentPadding:
//                       contentPadding ?? EdgeInsets.only(bottom: 3.h),
//                   hintStyle: AppTextStyles.body15w4
//                       .copyWith(color: AppColors.mediumBlack),
//                   border: InputBorder.none,
//                 )),
//           ),
//           trailing ?? const SizedBox.shrink()
//         ],
//       ),
//     );
//   }
// }
