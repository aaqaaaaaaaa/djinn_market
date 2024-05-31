// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/get_cards_usescase.dart';
import 'package:bizda_bor/fuatures/cart/presentation/manager/cards_bloc.dart';
import 'package:bizda_bor/fuatures/cart/presentation/pages/checkout_page.dart';
import 'package:bizda_bor/fuatures/cart/presentation/widgets/card_item_widget.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static Widget screen() {
    return BlocProvider(
      create: (context) => di<CardsBloc>()
        ..add(GetCardsEvent(
            params: const GetCardsParams(limit: 30, isOrdered: false))),
      child: const CartPage(),
    );
  }

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  num jamiSumma = 0.0;
  int? removedProductId;

  getJamiSumma(List<GetCardModel> card, [bool inBuilder = false]) {
    jamiSumma = 0;
    for (int i = 0; i < card.length; i++) {
      jamiSumma += (card[i].amount ?? 1) *
          (card[i].productPrice == 0
              ? Random().nextInt(50) * 1000
              : card[i].productPrice ?? 1);
    }
    if (!inBuilder) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          LocaleKeys.cart.tr(),
          style: AppTextStyles.body18w5.copyWith(color: AppColors.mediumBlack),
        ),
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () => context.pop(context),
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.mediumBlack.withOpacity(0.5)),
        ),
        elevation: 0,
      ),
      body: BlocConsumer<CardsBloc, CardsState>(
        listener: (context, state) async {
          if (state.status == CardsStatus.success) {
            getJamiSumma(state.cardsModel ?? []);
          } else if (state.status == CardsStatus.deleteLoading) {
            await Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: LocaleKeys.loading.tr(),
              message: LocaleKeys.card_deleting.tr(),
              duration: const Duration(seconds: 3),
            ).show(context);
          } else if (state.status == CardsStatus.deleteFailure) {
            await Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              title: LocaleKeys.error.tr(),
              message: LocaleKeys.card_deleting_error.tr(),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        },
        builder: (context, state) {
          if (state.status == CardsStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                size: 40.sp,
                color: AppColors.orange,
              ),
            );
          } else if (state.status == CardsStatus.updateSuccess) {
            print(removedProductId);
            if (removedProductId != null) {
              state.cardsModel?.removeWhere((element) {
                print(element.id == removedProductId);
                return element.id == removedProductId;
              });
            }
            getJamiSumma(state.cardsModel ?? [], true);
            removedProductId = null;
          } else if (state.status == CardsStatus.deleteSuccess) {
            getJamiSumma(state.cardsModel ?? [], true);
          } else if (state.status == CardsStatus.failure) {
            return Center(
              child: Text(
                state.error?.message ?? LocaleKeys.unknown_error.tr(),
                style: AppTextStyles.body16w5,
              ),
            );
          }
          if (state.cardsModel?.isNotEmpty ?? false) {
            return Column(
              children: [
                SizedBox(height: 19.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(Assets.icons.shoppingCard,
                          color: AppColors.orange),
                    ),
                    Text(
                      '${LocaleKeys.card_items_count.tr()}: ${state.cardsModel?.length ?? 0}',
                      style: AppTextStyles.body17w5,
                    )
                  ],
                ),
                Flexible(
                  child: ListView.separated(
                      padding: EdgeInsets.only(
                          top: 19.h, left: 20.w, right: 10.w, bottom: 20.h),
                      itemBuilder: (_, index) => CardItemWidget(
                            onRemoveTap: () {
                              removedProductId = state.cardsModel?[index].id;
                              print(removedProductId);
                              context.read<CardsBloc>().add(DeleteCardEvent(
                                  productId: state.cardsModel?[index].id));
                            },
                            cardModel: state.cardsModel?[index],
                            changeAmount: (value) {
                              state.cardsModel?[index].amount = value;
                              getJamiSumma(state.cardsModel ?? []);
                              setState(() {});
                              context.read<CardsBloc>().add(UpdateCardEvent(
                                    productId: state.cardsModel?[index].product,
                                    id: state.cardsModel?[index].id,
                                    amount: value,
                                  ));
                            },
                          ),
                      separatorBuilder: (context, index) =>
                          Divider(height: 44.h),
                      itemCount: state.cardsModel?.length ?? 0),
                ),
                if (state.cardsModel?.isNotEmpty ?? false)
                  Container(
                    padding: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.r),
                      ),
                      color: AppColors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  '${LocaleKeys.total_price.tr()}:',
                                  style: AppTextStyles.body16w5,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              FittedBox(
                                child: Text(
                                  '${jamiSumma.formatAsNum()} ${LocaleKeys.som.tr()}',
                                  style: AppTextStyles.body16w5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 8.h),
                          text: LocaleKeys.checkout.tr(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckOutPage.screen(
                                    state.cardsModel,
                                    jamiSumma,
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  )
              ],
            );
          }
          return Center(
            child: Text(
              LocaleKeys.card_empty.tr(),
              style: AppTextStyles.body16w5,
            ),
          );
        },
      ),
    );
  }
}
