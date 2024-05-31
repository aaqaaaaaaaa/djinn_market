import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/fuatures/main/data/model/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselWidget extends StatelessWidget {
  final CarouselController controller;
  final List<CarouselBannersModel>? imageList;

  const CarouselWidget(
      {super.key, required this.imageList, required this.controller});

  @override
  Widget build(BuildContext context) {
    return (imageList?.isNotEmpty ?? false)
        ? (imageList?.length == 1)
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.icons.newLogo)),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                width: MediaQuery.of(context).size.width,
                height: 172.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: '${imageList?.first.image}',
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) => Image.asset(
                        Assets.icons.newLogo,
                        color: AppColors.orange),
                    width: MediaQuery.of(context).size.width - 60.w,
                  ),
                ),
              )
            : CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayInterval: const Duration(seconds: 8),
                    enlargeCenterPage: true,
                    aspectRatio: 310.w / 172.h,
                    height: 172.h),
                items: imageList
                    ?.map((e) => Container(
                          decoration: BoxDecoration(
                              color: AppColors.grey1.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12.r)),
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CachedNetworkImage(
                              imageUrl: '${e.image}',
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) =>
                                  Image.asset(Assets.icons.newLogo),
                              width: MediaQuery.of(context).size.width - 60.w,
                            ),
                          ),
                        ))
                    .toList())
        : const SizedBox();
  }
}
