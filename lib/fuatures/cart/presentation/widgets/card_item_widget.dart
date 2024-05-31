import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/locale_keys.g.dart';

class CardItemWidget extends StatefulWidget {
  const CardItemWidget(
      {super.key,
      this.cardModel,
      required this.changeAmount,
      required this.onRemoveTap});

  final GetCardModel? cardModel;
  final ValueChanged<int> changeAmount;
  final VoidCallback onRemoveTap;

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  int amount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print(widget.cardModel?.amount);
    amount = widget.cardModel?.amount ?? 1;
  }

  void _increment() {
    setState(() {
      amount++;
      widget.changeAmount(amount);
    });
  }

  void _decrement() {
    if (amount > 1) {
      setState(() {
        amount--;
        widget.changeAmount(amount);
      });
    }
  }

  void _startIncrementTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _increment();
    });
  }

  void _startDecrementTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _decrement();
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
        child: Row(
          children: [
            Container(
              width: 96.w,
              height: 96.w,
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
                  imageUrl: widget.cardModel?.productImage ?? '',
                  progressIndicatorBuilder: (context, url, progress) =>
                      SvgPicture.asset(Assets.icons.shoppingCard,
                          width: 46.w, fit: BoxFit.cover),
                  errorWidget: (context, url, error) => Center(
                      child: SvgPicture.asset(Assets.icons.shoppingCard,
                          width: 46.w, fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: AutoSizeText(
                        context.locale.languageCode == 'ru'
                            ? widget.cardModel?.productNameRu ??
                                widget.cardModel?.productNameUz ??
                                ''
                            : widget.cardModel?.productNameUz ?? '',
                        style: AppTextStyles.body15w5,
                        minFontSize: 12,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.only(right: 10.w),
                        alignment: Alignment.topRight,
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onPressed: widget.onRemoveTap,
                        icon: SvgPicture.asset(
                          Assets.icons.clear,
                          width: 20.w,
                          color: Colors.red.withOpacity(0.5),
                        ))
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.65,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          '${widget.cardModel?.productPrice == 0 ? (Random().nextInt(100) * 1000).formatAsNum() : widget.cardModel?.productPrice?.formatAsNum() ?? ''} ${LocaleKeys.som.tr()}',
                          style: AppTextStyles.body15w5
                              .copyWith(color: AppColors.blue),
                          minFontSize: 12,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                          onTapDown: (_) => _startDecrementTimer(),
                          onTapUp: (_) => _stopTimer(),
                          onTap: _decrement,
                          child: SvgPicture.asset(
                            Assets.icons.removeCircle,
                            width: 40.sp,
                          )),
                      AutoSizeText(
                        '$amount',
                        style: AppTextStyles.body15w5
                            .copyWith(color: AppColors.fullBlack),
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                          onTap: _increment,
                          onTapDown: (details) => _startIncrementTimer(),
                          onTapUp: (details) => _stopTimer(),
                          child: SvgPicture.asset(
                            Assets.icons.addCircle,
                            width: 40.sp,
                          )),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
