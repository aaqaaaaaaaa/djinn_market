import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_style.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.imagePath,
    required this.text1,
    required this.text2,
  });

  final String imagePath;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 240.h,
          width: 240.h,
          margin: EdgeInsets.only(bottom: 26.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightBlack.withOpacity(.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Image.asset(imagePath),
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          child: AutoSizeText(
            text1,
            minFontSize: 12,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppTextStyles.body28w7,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: AutoSizeText(
            text2,
            maxLines: 2,
            minFontSize: 12,
            style: AppTextStyles.body17w4
                .copyWith(color: AppColors.mediumBlack, letterSpacing: -0.408),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
