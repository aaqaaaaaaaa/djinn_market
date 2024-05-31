import 'package:another_flushbar/flushbar.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/pages/category_detail_page.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common/all_contants.dart';
import '../bloc/category/category_bloc.dart';
import 'category_item.dart';

class CategoriesGridWidget extends StatefulWidget {
  const CategoriesGridWidget(
      {this.listCategories,
      super.key,
      this.isSeeAll = true,
      required this.onNoConnection});

  final List<CategoryModel>? listCategories;
  final bool isSeeAll;
  final VoidCallback onNoConnection;

  @override
  State<CategoriesGridWidget> createState() => _CategoriesGridWidgetState();
}

class _CategoriesGridWidgetState extends State<CategoriesGridWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CategoryBloc>()..add(GetAllCetgories()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 24.w),
            //   child: Stack(
            //     alignment: Alignment.center,
            //     children: [
            //       SizedBox(
            //           height: 45.h,
            //           child: SvgPicture.asset(
            //               'assets/icons/products_titile_bg.svg')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      LocaleKeys.categories.tr(),
                      style:
                          AppTextStyles.body14w4
                    ),
                  ),
            //     ],
            //   ),
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120.h,
              child: BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) async {
                  if (state.status == CategoryStatus.failure) {
                    await Flushbar(
                      flushbarPosition: FlushbarPosition.TOP,
                      title: LocaleKeys.error.tr(),
                      message: state.error?.message,
                      duration: const Duration(seconds: 3),
                    ).show(context);
                  }
                },
                builder: (context, state) {
                  if (state.status == CategoryStatus.success) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.w),
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.only(top: 12.h, left: 10.w, right: 10.w),
                      itemCount: widget.listCategories?.length ?? 0,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        overlayColor:
                            MaterialStateProperty.all(AppColors.transparent),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailPage(
                                categoryModel: widget.listCategories?[index]),
                          ),
                        ),
                        child: CategoryItem(
                            categories: widget.listCategories?[index]),
                      ),
                    );
                  }
                  if (state.status == CategoryStatus.failure) {
                    return Center(
                      child: Column(
                        children: [
                          CustomButton(
                            height: 80.h,
                            elevation: 0,
                            buttonColor: AppColors.backgroundColor,
                            width: 120.w,
                            margin: EdgeInsets.only(top: 24.h),
                            onPressed: () async {
                              widget.onNoConnection();
                              context
                                  .read<CategoryBloc>()
                                  .add(GetAllCetgories());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: Column(
                                children: [
                                  const Icon(CupertinoIcons.refresh),
                                  Text(LocaleKeys.refresh.tr(),
                                      style: AppTextStyles.body14w4),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                          size: 40.sp, color: AppColors.orange),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
