import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/custom_textfield.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 140.h),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: AppColors.white, boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 3.r,
                offset: const Offset(0, 3))
          ]),
          padding:
              EdgeInsets.only(left: 24.w, right: 14.w, top: 20.h, bottom: 10.h),
          child: Row(
            children: [
              Image.asset(Assets.images.onlineBuy, width: 40.w, height: 40.w),
              SizedBox(width: 8.w),
              Flexible(
                child: CustomTextField(
                  controller: controller,
                  radius: 8.r,
                  height: 36.h,
                  hintText: LocaleKeys.search.tr(),
                  hintStyle:
                      AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
                  readOnly: true,
                  onTap: () {
                    context.go(Routes.searchPage);
                  },
                  borderColor: AppColors.transparent,
                  backgroundColor: AppColors.colorF2,
                  trailing: Container(
                    width: 44.w,
                    height: 36.h,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(10.r))),
                    child: SvgPicture.asset(Assets.icons.search,
                        width: 22.w, color: AppColors.orange),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(735.w, 180.h);
}
