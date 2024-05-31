import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // PageController pageController = PageController();
  final List<BottomNavModel> bottomList = [
    BottomNavModel(
      label: LocaleKeys.home.tr(),
      icon: Assets.icons.navHome,
      selectedIcon: Assets.icons.navHomeFilled,
    ),
    BottomNavModel(
      label: LocaleKeys.favurites.tr(),
      icon: Assets.icons.heart,
      selectedIcon: Assets.icons.navHeartFilled,
    ),
    BottomNavModel(
      label: LocaleKeys.search.tr(),
      icon: Assets.icons.search,
      selectedIcon: Assets.icons.navSearchFilled,
    ),
    BottomNavModel(
      label: LocaleKeys.cart.tr(),
      icon: Assets.icons.navCart,
      selectedIcon: Assets.icons.navCartFilled,
    ),
    BottomNavModel(
      label: LocaleKeys.profile_bnb.tr(),
      icon: Assets.icons.navUser,
      selectedIcon: Assets.icons.navUserFilled,
    ),
  ];

  DateTime? currentBackPressTime;

  Future<bool> _onWillPop() async {
    if (currentBackPressTime == null ||
        DateTime.now().difference(currentBackPressTime ?? DateTime.now()) >
            const Duration(seconds: 2)) {
      currentBackPressTime = DateTime.now();
      Fluttertoast.showToast(
        msg: LocaleKeys.on_will_pop.tr(),
        backgroundColor: AppColors.black.withOpacity(0.6),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: SizedBox(
          // height: 30.h,
          child: BottomNavigationBar(
            onTap: (value) {
              onItemTapped(value, context);
            },
            selectedFontSize: 12.sp,
            selectedLabelStyle: AppTextStyles.body10w4,
            selectedItemColor: AppColors.orange,
            unselectedItemColor: AppColors.orange.withOpacity(0.5),
            unselectedLabelStyle: AppTextStyles.body10w4,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            currentIndex: calculateSelectedIndex(context),
            showUnselectedLabels: true,
            items: List.generate(
                bottomList.length,
                (index) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      calculateSelectedIndex(context) == index
                          ? bottomList[index].selectedIcon
                          : bottomList[index].icon,
                      color: calculateSelectedIndex(context) == index
                          ? AppColors.orange
                          : AppColors.orange.withOpacity(0.5),
                      width: 24.w,
                      height: 24.w,
                      fit: BoxFit.cover,
                    ),
                    label: bottomList[index].label)),
          ),
        ),
      ),
    );
  }
}

class BottomNavModel {
  final String icon, label, selectedIcon;

  BottomNavModel(
      {required this.icon, required this.label, required this.selectedIcon});
}
