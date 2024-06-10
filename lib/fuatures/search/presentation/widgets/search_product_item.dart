import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/pages/product_detail.dart';
import 'package:bizda_bor/fuatures/search/data/models/product_model.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchProductItem extends StatelessWidget {
  const SearchProductItem({super.key, required this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail.screen(id: product?.id),
            ));
      },
      overlayColor: MaterialStateProperty.all(AppColors.transparent),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            Container(
              height: 48.w,
              width: 48.w,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  // image: DecorationImage(
                  //   opacity: 0.5,
                  //   image: AssetImage(Assets.images.onlineBuy),
                  // ),
                  borderRadius: BorderRadius.circular(8.r)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  product?.compressImage ?? '',
                  errorBuilder: (context, url, progress) => Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Opacity(
                        opacity: 0.0,
                        child:
                            Image.asset(Assets.images.onlineBuy)),
                  )),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.1,
                          child: Text(
                            context.locale.languageCode == 'ru'
                                ? product?.nameRu ?? ''
                                : product?.nameUz ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body15w4,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          alignment: Alignment.centerRight,
                          child: AutoSizeText(
                            '${product?.price?.formatAsNum() ?? ''} ${LocaleKeys.som.tr()}',
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            minFontSize: 10,
                            style: AppTextStyles.body13w5
                                .copyWith(color: AppColors.fullBlack),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.1,
                          child: AutoSizeText(
                            context.locale.languageCode == 'ru'
                                ? product?.descriptionRu ?? ''
                                : product?.descriptionUz ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body11w4.copyWith(
                              color: AppColors.mediumBlack,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
