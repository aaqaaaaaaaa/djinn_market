import 'dart:async';

import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initShared();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 4) {
        timer.cancel();
        prefs?.getBool('has_user') ?? false
            ? context.go(Routes.mainPage)
            : context.go(Routes.onboardingPage);
      }
    });
  }

  initShared() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Stack(
        children: [
          // Positioned(
          //     bottom: -50.h,
          //     left: MediaQuery.of(context).size.width / 3,
          //     child: SvgPicture.asset(
          //       Assets.icons.logoB,
          //       color: AppColors.colorEA,
          //       height: MediaQuery.of(context).size.height / 1.5,
          //     )),
          Align(
            alignment: Alignment.center,
            child: Image.asset(Assets.icons.newLogo),
          ),
        ],
      ),
    );
  }
}
