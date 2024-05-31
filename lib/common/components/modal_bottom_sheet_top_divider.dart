import 'package:bizda_bor/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalBottomSheetTopDivider extends StatelessWidget {
  const ModalBottomSheetTopDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 67.w,
      height: 5.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8.r)),
    );
  }
}
