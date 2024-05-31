import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/all_contants.dart';
import '../../data/model/categories_model.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categories});

  final CategoryModel? categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.w,
      width: 70.w,
      padding: EdgeInsets.all(6.h),
      child: Column(
        children: [
          Flexible(
            child: CachedNetworkImage(
              imageUrl: categories?.compressImage ?? '',
              height: 60.h,
              width: 60.h,
              cacheManager: CacheManager(Config('${categories?.compressImage}',
                  stalePeriod: const Duration(hours: 4))),
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "${context.locale.languageCode == 'ru' ? categories?.nameRu : categories?.nameUz}",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body10w5
                  .copyWith(color: AppColors.fullBlack, fontSize: 7.sp),
            ),
          ),
        ],
      ),
    );
  }
}
