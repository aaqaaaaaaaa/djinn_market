import 'package:bizda_bor/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetDivider extends StatelessWidget {
  const BottomSheetDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4.h,
        width: 24.w,
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
            color: AppColors.mediumBlack,
            borderRadius: BorderRadius.circular(4.r)),
      ),
    );
  }
}
