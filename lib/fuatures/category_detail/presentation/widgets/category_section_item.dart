import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_decorations.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySectionItem extends StatelessWidget {
  const CategorySectionItem(
      {super.key, required this.sectionName, required this.isSelected});

  final String? sectionName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.w,
      width: 90.w,
      alignment: Alignment.center,
      padding: EdgeInsets.all(6.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: isSelected
            ? Border.all(
                color: AppColors.blue,
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside)
            : null,
        borderRadius: BorderRadius.circular(10.r),
        // shape: BoxShape.circle,
        boxShadow: [AppDecorations.defaultBoxShadow],
      ),
      child: Text(
        '$sectionName',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.center,
        style: AppTextStyles.body10w5.copyWith(color: AppColors.fullBlack),
      ),
    );
  }
}
