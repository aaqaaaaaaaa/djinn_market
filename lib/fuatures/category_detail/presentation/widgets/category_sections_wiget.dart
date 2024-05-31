import 'package:bizda_bor/fuatures/category_detail/data/model/category_section_model.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/bloc/bloc/category_section_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common/all_contants.dart';

class CategorySectionsWidget extends StatefulWidget {
  const CategorySectionsWidget({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<CategorySectionsWidget> createState() => _CategorySectionsWidgetState();
}

class _CategorySectionsWidgetState extends State<CategorySectionsWidget> {
  @override
  void initState() {
    super.initState();
    context
        .read<CategorySectionBloc>()
        .add(GetCategorySectionList(categoryId: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorySectionBloc, CategorySectionState>(
      builder: (context, state) {
        if (state.status == CategorySectionStatus.sectionSuccess) {
          List<CategorySectionModel> listCategorySections =
              state.categorySectionList ?? [];
          return Column(
            children: List.generate(
              listCategorySections.length,
              (index) => Container(
                height: 60.h,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.black.withOpacity(.2), blurRadius: 5)
                  ],
                ),
                child: Text(
                  listCategorySections[index].nameUz!,
                  style: AppTextStyles.body16w5,
                ),
              ),
            ),
          );
        }
        if (state.status == CategorySectionStatus.sectionFailure) {
          return Center(
            child:
                Text(state.error?.message ?? '', style: AppTextStyles.body13w5),
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
                color: AppColors.orange, size: 24.sp),
          );
        }
      },
    );
  }
}
