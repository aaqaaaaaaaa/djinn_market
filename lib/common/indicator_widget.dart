import 'package:bizda_bor/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicatorWidget extends StatefulWidget {
  const IndicatorWidget(
      {super.key, required this.pageController, required this.pageLength});

  final int pageLength;
  final PageController pageController;

  @override
  State<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  late PageController pageController;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = widget.pageController;
    pageController.addListener(() {
      setState(() {
        activeIndex = pageController.page!.floor();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.pageLength,
        (index) => Container(
          height: 8.h,
          width: 8.h,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == activeIndex
                ? AppColors.orange
                : AppColors.orange.withOpacity(.3),
          ),
        ),
      ),
    );
  }
}
