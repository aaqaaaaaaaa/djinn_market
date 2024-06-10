import 'dart:math';

import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/badge_widget.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/part_title.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/product_grid_widget.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/use_cse/add_to_card_usescase.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/manager/pr_detail_bloc.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, this.childSectionId, required this.initModel})
      : super(key: key);
  final int? childSectionId;
  final GetProductModel? initModel;

  static Widget screen(
      {int? id, int? childSectionId, GetProductModel? initModel}) {
    return BlocProvider(
      create: (context) => di<PrDetailBloc>()
        ..add(GetPrDetailEvent(id: id))
        ..add(GetProductEvent(id: childSectionId)),
      child:
          ProductDetail(childSectionId: childSectionId, initModel: initModel),
    );
  }

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final PageController pageController = PageController();
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrDetailBloc, PrDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            leadingWidth: 60.w,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios,
                  color: AppColors.mediumBlack.withOpacity(0.5)),
            ),
            elevation: 0,
          ),
          body: state.status == PrDetailStateStatus.loading
              ? Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.initModel?.compressImage ?? '',
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          size: 40.sp,
                          color: AppColors.orange,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset(Assets.icons.newLogo),
                      fit: BoxFit.contain,
                      height: 400.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          Text(
                            context.locale.languageCode == 'ru'
                                ? widget.initModel?.descriptionRu ?? ''
                                : widget.initModel?.descriptionUz ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body16w5
                                .copyWith(color: AppColors.fullBlack),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${LocaleKeys.price.tr()}:',
                                    style: AppTextStyles.body14w4
                                        .copyWith(color: AppColors.fullBlack),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      '${widget.initModel?.price?.formatAsNum() ?? ''} ${LocaleKeys.som.tr()}',
                                      style: AppTextStyles.body18w5
                                          .copyWith(color: AppColors.orange),
                                    ),
                                  ),
                                ],
                              ),
                              FittedBox(
                                child: Text(
                                  '${LocaleKeys.v_nalichii.tr()}: ${widget.initModel?.amount?.formatAsNum() ?? '0'}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.body16w5
                                      .copyWith(color: AppColors.orange),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
                            child: Text(
                              '${LocaleKeys.description.tr()}:',
                              style: AppTextStyles.body15w5
                                  .copyWith(color: AppColors.fullBlack),
                            ),
                          ),
                          Text(
                            context.locale.languageCode == 'ru'
                                ? state.productDetailModel?.descriptionRu ?? ''
                                : state.productDetailModel?.descriptionUz ?? '',
                            style: AppTextStyles.body14w4
                                .copyWith(color: AppColors.mediumBlack),
                          ),
                          SizedBox(height: 24.h),
                          PartTitleSeeAllWidget(
                            title: LocaleKeys.similar_pr.tr(),
                          ),
                          SizedBox(height: 12.h),
                        ],
                      ),
                    ),
                  ],
                )
              : state.status == PrDetailStateStatus.failure
                  ? Center(
                      child: Text(
                      state.error?.message ?? '',
                      style: AppTextStyles.body16w5,
                    ))
                  : NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        if (state.productDetailModel?.images?.isNotEmpty ??
                            false)
                          SliverToBoxAdapter(
                            child: Container(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: PageView.builder(
                                controller: pageController,
                                itemCount:
                                    state.productDetailModel?.images?.length,
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${state.productDetailModel?.images?[index].image}',
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: LoadingAnimationWidget
                                          .horizontalRotatingDots(
                                        size: 40.sp,
                                        color: AppColors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          SliverToBoxAdapter(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      state.productDetailModel?.image ?? '',
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: LoadingAnimationWidget
                                        .horizontalRotatingDots(
                                      size: 40.sp,
                                      color: AppColors.orange,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Assets.icons.newLogo),
                                  fit: BoxFit.contain,
                                  height: 400.h,
                                ),
                              ),
                            ),
                          ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 24.h),
                                Text(
                                  context.locale.languageCode == 'ru'
                                      ? state.productDetailModel?.nameRu ?? ''
                                      : state.productDetailModel?.nameUz ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.body16w5
                                      .copyWith(color: AppColors.fullBlack),
                                ),
                                SizedBox(height: 24.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${LocaleKeys.price.tr()}:',
                                          style: AppTextStyles.body14w4
                                              .copyWith(
                                                  color: AppColors.fullBlack),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            '${state.productDetailModel?.price == 0 ? (Random().nextInt(100) * 1000).toString().formatAsNumber() : state.productDetailModel?.price?.formatAsNum() ?? ''} ${LocaleKeys.som.tr()}',
                                            style: AppTextStyles.body18w5
                                                .copyWith(
                                                    color: AppColors.orange),
                                          ),
                                        ),
                                      ],
                                    ),
                                    FittedBox(
                                      child: Text(
                                        '${LocaleKeys.v_nalichii.tr()}: ${state.productDetailModel?.amount == 0 ? Random().nextInt(10) * 10 : state.productDetailModel?.amount?.formatAsNum() ?? '0'}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.body16w5
                                            .copyWith(color: AppColors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 24.h, bottom: 12.h),
                                  child: Text(
                                    '${LocaleKeys.description.tr()}:',
                                    style: AppTextStyles.body15w5
                                        .copyWith(color: AppColors.fullBlack),
                                  ),
                                ),
                                Text(
                                  context.locale.languageCode == 'ru'
                                      ? state.productDetailModel
                                              ?.descriptionRu ??
                                          ''
                                      : state.productDetailModel
                                              ?.descriptionUz ??
                                          '',
                                  style: AppTextStyles.body14w4
                                      .copyWith(color: AppColors.mediumBlack),
                                ),
                                SizedBox(height: 24.h),
                                PartTitleSeeAllWidget(
                                  title: LocaleKeys.similar_pr.tr(),
                                ),
                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                      body: SizedBox(
                        height: MediaQuery.of(context).size.height - 150.h,
                        width: MediaQuery.of(context).size.width,
                        child: RefreshIndicator.adaptive(
                          onRefresh: () async {
                            context.read<PrDetailBloc>().add(
                                GetProductEvent(id: widget.childSectionId));
                          },
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollEndNotification &&
                                  notification.metrics.pixels ==
                                      notification.metrics.maxScrollExtent) {
                                context.read<PrDetailBloc>().add(
                                      GetProductEvent(
                                        id: state
                                            .productDetailModel?.childSection,
                                      ),
                                    );
                              }
                              return false;
                            },
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 160.w / 260.h,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 20.w,
                              ),
                              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 70.w),
                              itemBuilder: (context, index) => InkWell(
                                  overlayColor: MaterialStateProperty.all(
                                      AppColors.transparent),
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetail.screen(
                                            id: state.productModel?[index].id,
                                            childSectionId: state
                                                .productModel?[index]
                                                .childSection,
                                          ),
                                        ),
                                      ),
                                  child: ProductItemBody(
                                      onFavDeleted: (value) {},
                                      product: state.productModel?[index])),
                              itemCount: state.productModel?.length ?? 0,
                            ),
                          ),
                        ),
                      ),
                    ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: addToCardWidget(context, state),
        );
      },
    );
  }

  Container addToCardWidget(BuildContext context, PrDetailState state) {
    return Container(
      height: 73.h,
      width: MediaQuery.of(context).size.width,
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state.status == PrDetailStateStatus.addToCardSuccess
              ? BadgeWidget(
                  value: '1',
                  badgeRadius: 100.r,
                  child: InkWell(
                    onTap: () {
                      context.go(Routes.chartPage);
                    },
                    child: Container(
                      height: 48.h,
                      width: MediaQuery.of(context).size.width - 50.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.orange,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: FittedBox(
                        child: Text(
                          LocaleKeys.go_to_card.tr(),
                          style: AppTextStyles.body14w6
                              .copyWith(color: AppColors.orange),
                        ),
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    context.read<PrDetailBloc>().add(
                          AddToCardProductEvent(
                            params: AddToCardParams(
                              amount: 1,
                              productId: state.productDetailModel?.id,
                              ordered: false,
                            ),
                          ),
                        );
                  },
                  child: Container(
                    height: 48.h,
                    width: MediaQuery.of(context).size.width - 50.w,
                    //160.w
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.orange),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    child: FittedBox(
                      child: Text(
                        LocaleKeys.add_to_card.tr(),
                        style: AppTextStyles.body14w6
                            .copyWith(color: AppColors.orange),
                      ),
                    ),
                  ),
                ),
          // SizedBox(width: 12.h),
          // Container(
          //   width: 160.w,
          //   height: 48.h,
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.symmetric(vertical: 13.h),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.r),
          //     color: AppColors.orange,
          //   ),
          //   child: FittedBox(
          //     child: Text(
          //       'Buy Now'.toUpperCase(),
          //       style: AppTextStyles.body14w6
          //           .copyWith(color: AppColors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
