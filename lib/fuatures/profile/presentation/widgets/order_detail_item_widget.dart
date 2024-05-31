import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/fuatures/profile/data/models/order_model.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailItemWidget extends StatefulWidget {
  const OrderDetailItemWidget({super.key, this.product});

  final Products? product;

  @override
  State<OrderDetailItemWidget> createState() => _OrderDetailItemWidgetState();
}

class _OrderDetailItemWidgetState extends State<OrderDetailItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: 90.w,
            height: 90.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 4.r,
                      offset: Offset(0, 4.h))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: (widget.product?.image?.contains('https') ?? false)
                    ? '${widget.product?.image}'
                    : 'https://bizda-bor.uz${widget.product?.image}',
                progressIndicatorBuilder: (context, url, progress) =>
                    SvgPicture.asset(Assets.icons.shoppingCard,
                        width: 56.w, fit: BoxFit.cover),
                errorWidget: (context, url, error) => Center(
                    child: SvgPicture.asset(Assets.icons.shoppingCard,
                        width: 56.w, fit: BoxFit.cover)),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.78,
                child: AutoSizeText(
                  widget.product?.nameUz ?? '',
                  style: AppTextStyles.body14w5,
                  minFontSize: 12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: AutoSizeText(
                  '${widget.product?.price?.formatAsNum() ?? ''} ${LocaleKeys.som.tr()}',
                  style: AppTextStyles.body13w5.copyWith(color: AppColors.blue),
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              (widget.product?.amount != null ||
                      (widget.product?.amount ?? 0) > 0)
                  ? AutoSizeText(
                      '${LocaleKeys.soni.tr()}: ${widget.product?.amount ?? 0}',
                      style: AppTextStyles.body13w5
                          .copyWith(color: AppColors.fullBlack),
                      minFontSize: 10,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
