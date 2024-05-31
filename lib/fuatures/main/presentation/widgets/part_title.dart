import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/material.dart';

class PartTitleSeeAllWidget extends StatelessWidget {
  const PartTitleSeeAllWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
  });

  final String? title, subtitle;
  final Function()? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: AppTextStyles.body15w5.copyWith(color: AppColors.fullBlack),
        ),
        if (subtitle != null)
          InkWell(
            onTap: onSeeAll,
            overlayColor: MaterialStateProperty.all(AppColors.transparent),
            child: Text(
              subtitle ?? '',
              style:
                  AppTextStyles.body12w5.copyWith(color: AppColors.mediumBlack),
            ),
          ),
      ],
    );
  }
}
