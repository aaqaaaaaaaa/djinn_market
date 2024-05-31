import 'package:bizda_bor/common/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBulimiWidget extends StatelessWidget {
  const SearchBulimiWidget(
  {super.key, required this.data, required this.title, this.onItemTap});

  final String title;
  final List<Widget> data;
  final Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h, top: 24.h),
          child: Text(title, style: AppTextStyles.body12w4),
        ),
        Wrap(
          runSpacing: 8.w,
          spacing: 8.w,
          children: [...data],
        ),
      ],
    );
  }
}
