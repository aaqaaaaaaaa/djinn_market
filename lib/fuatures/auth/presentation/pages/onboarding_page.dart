import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_decorations.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/fuatures/auth/presentation/widgets/indicator_widget.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/widgets/onboarding_item.dart';

class OnboaringPage extends StatefulWidget {
  const OnboaringPage({super.key});

  @override
  State<OnboaringPage> createState() => _OnboaringPageState();
}

class _OnboaringPageState extends State<OnboaringPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                children: [
                  OnboardingItem(
                    text1: LocaleKeys.onb1_title.tr(),
                    imagePath: Assets.images.onlineBuy,
                    text2: LocaleKeys.onb1_subtitle.tr(),
                  ),
                  OnboardingItem(
                    text1: LocaleKeys.onb2_title.tr(),
                    imagePath: Assets.images.onlineBuy2,
                    text2: LocaleKeys.onb2_subtitle.tr(),
                  ),
                  OnboardingItem(
                    text1: LocaleKeys.onb3_title.tr(),
                    imagePath: Assets.images.onlineBuy3,
                    text2: LocaleKeys.onb3_subtitle.tr(),
                  ),
                ],
              ),
            ),
            IndicatorWidget(pageController: pageController),
            TextButton(
              onPressed: () {
                if (pageController.page == 2) {
                  context.pushReplacement(Routes.loginPage);
                } else {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn);
                }
              },
              style: AppDecorations.buttonStyle(
                bgColor: AppColors.orange,
                borderRadius: 8.r,
                size: Size(double.maxFinite, 48.h),
              ),
              child: Text(
                LocaleKeys.contin.tr(),
                style: AppTextStyles.body15w6.copyWith(
                  color: AppColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
