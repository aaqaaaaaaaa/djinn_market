import 'dart:async';
import 'dart:math';

import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/main/presentation/bloc/category/category_bloc.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductItemBody extends StatefulWidget {
  const ProductItemBody({
    super.key,
    required this.product,
    required this.onFavDeleted,
    this.favId,
  });

  final GetProductModel? product;
  final int? favId;
  final ValueChanged<int?> onFavDeleted;

  @override
  State<ProductItemBody> createState() => _ProductItemBodyState();
}

class _ProductItemBodyState extends State<ProductItemBody> {
  bool isFavorite = false, isAddToCard = false;
  int? userId;
  int amount = 0;
  int lastPrIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product?.isFavourite ?? false;
    final box = Hive.box(UserModel.boxKey);
    UserModel? user = box.get(UserModel.boxKey);
    userId = user?.id;
  }

  void _increment(BuildContext context) {
    setState(() {
      amount++;

      context.read<CategoryBloc>().add(
            CreateFavouriteEvent(productId: widget.product?.id),
          );
    });
  }

  void updateAmount(
      BuildContext context, int cardId, int amount, int productId) {
    context
        .read<CategoryBloc>()
        .add(UpdateCardEvent(amount: amount, productId: productId, id: cardId));
  }

  void _decrement(BuildContext context) {
    if (amount > 1) {
      setState(() => amount--);
    }
  }

  void _startIncrementTimer(context) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _increment(context);
    });
  }

  void _startDecrementTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      _decrement(context);
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CategoryBloc>(),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: 216.h,
            width: 167.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              // boxShadow: [AppDecorations.defaultBoxShadow],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 167.h,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.15),
                              blurRadius: 5.r)
                        ],
                        color: AppColors.white,
                        image: const DecorationImage(
                          opacity: 0.5,
                          image: AssetImage('assets/images/logo_b_only.png'),
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.network(
                          (widget.product?.compressImage?.contains('https') ??
                                  false)
                              ? '${widget.product?.compressImage}'
                              : 'https://bizda-bor.uz${widget.product?.compressImage}',
                          errorBuilder: (context, url, error) {
                            return Container(
                                height: 167.h,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.white),
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Image.asset(
                                    Assets.images.onlineBuy3,
                                    height: 60.h,
                                    width: 60.h,
                                    fit: BoxFit.cover,
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: InkWell(
                          onTap: () {
                            if (!isFavorite) {
                              context.read<CategoryBloc>().add(
                                  CreateFavouriteEvent(
                                      productId: widget.product?.id));
                            } else {
                              context.read<CategoryBloc>().add(
                                  DeleteFavouriteEvent(
                                      productId:
                                          widget.favId ?? widget.product?.id));
                              widget.onFavDeleted(
                                  widget.favId ?? widget.product?.id);
                            }
                            setState(() => isFavorite = !isFavorite);
                          },
                          child: isFavorite
                              ? Icon(
                                  CupertinoIcons.suit_heart_fill,
                                  color: AppColors.orange,
                                )
                              : Icon(
                                  CupertinoIcons.suit_heart,
                                  color: AppColors.orange,
                                )),
                    )
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 55.h,
                        padding: EdgeInsets.only(top: 12.h),
                        child: Text(
                          context.locale.languageCode == 'ru'
                              ? widget.product?.nameRu ??
                                  widget.product?.nameUz ??
                                  ''
                              : widget.product?.nameUz ?? '',
                          maxLines: 2,
                          style: AppTextStyles.body10w4
                              .copyWith(color: AppColors.color26),
                        ),
                      ),
                      Container(
                        height: 24.h,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.9,
                        padding: EdgeInsets.only(left: 3.w, top: 3.h),
                        decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(6.r)),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.r),
                              ),
                              border:
                                  Border.all(color: AppColors.white, width: 1)),
                          child: FittedBox(
                            child: Text(
                              '${widget.product?.price == 0 ? (Random().nextInt(100) * 1000).toString().formatAsNumber() : widget.product?.price?.toString().formatAsNumber()} ${LocaleKeys.som.tr()}',
                              maxLines: 1,
                              style: AppTextStyles.body10w4
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      //
                      //     ///suda
                      //     (isAddToCard)
                      //         ? SizedBox(
                      //             child: Row(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 GestureDetector(
                      //                     onTapDown: (_) =>
                      //                         _startDecrementTimer(context),
                      //                     onTapUp: (_) => _stopTimer(),
                      //                     onTap: () => _decrement(context),
                      //                     child: Transform.scale(
                      //                       scale: 1.2,
                      //                       child: SvgPicture.asset(
                      //                         Assets.icons.removeCircle,
                      //                         width: 40.sp,
                      //                         color: AppColors.orange,
                      //                       ),
                      //                     )),
                      //                 Padding(
                      //                   padding:
                      //                       EdgeInsets.symmetric(horizontal: 8.w),
                      //                   child: AutoSizeText(
                      //                     '$amount',
                      //                     style: AppTextStyles.body15w6
                      //                         .copyWith(color: AppColors.fullBlack),
                      //                     minFontSize: 10,
                      //                     maxLines: 1,
                      //                     overflow: TextOverflow.ellipsis,
                      //                   ),
                      //                 ),
                      //                 GestureDetector(
                      //                     onTap: () => _increment(context),
                      //                     onTapDown: (details) =>
                      //                         _startIncrementTimer(context),
                      //                     onTapUp: (details) => _stopTimer(),
                      //                     child: Transform.scale(
                      //                       scale: 1.2,
                      //                       child: SvgPicture.asset(
                      //                         Assets.icons.addCircle,
                      //                         width: 40.sp,
                      //                         height: 40.sp,
                      //                         color: AppColors.orange,
                      //                       ),
                      //                     )),
                      //               ],
                      //             ),
                      //           )
                      //         : Align(
                      //             child: Container(
                      //               width: double.infinity,
                      //               height: 32.w,
                      //               alignment: Alignment.center,
                      //               margin: EdgeInsets.only(top: 8.h),
                      //               decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(8.r),
                      //                   border: Border.all(
                      //                       color: AppColors.orange, width: 1)),
                      //               child: InkWell(
                      //                 onTap: () {
                      //                   amount++;
                      //                   isAddToCard = true;
                      //                   setState(() {});
                      //                   context.read<CategoryBloc>().add(
                      //                         CreateFavouriteEvent(
                      //                           productId: widget.product?.id,
                      //                         ),
                      //                       );
                      //                 },
                      //                 child: Row(
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   children: [
                      //                     FittedBox(
                      //                       child: Text(
                      //                         LocaleKeys.to_card.tr(),
                      //                         style: AppTextStyles.body12w4
                      //                             .copyWith(color: AppColors.orange),
                      //                       ),
                      //                     ),
                      //                     SvgPicture.asset(
                      //                       Assets.icons.basket,
                      //                       width: 28.r,
                      //                       color: AppColors.orange,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                    ])
              ],
            ),
          );
        },
      ),
    );
  }
}
