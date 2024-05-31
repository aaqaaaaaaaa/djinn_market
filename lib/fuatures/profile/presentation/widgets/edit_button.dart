import 'package:bizda_bor/common/all_contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditButton extends StatelessWidget {
  const EditButton(
      {super.key,
      this.onTap,
      this.width,
      this.height,
      this.widget,
      this.color});

  final Function()? onTap;
  final double? width;
  final double? height;
  final Widget? widget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
              color: color ?? AppColors.grey1,
              borderRadius: BorderRadius.circular(8.r)),
          child: widget ?? SvgPicture.asset(Assets.icons.edit)),
    );
  }
}
