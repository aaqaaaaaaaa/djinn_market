import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_decorations.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/profile/presentation/manager/orders_bloc.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderStoryPage extends StatefulWidget {
  const OrderStoryPage({super.key});

  static Widget screen() {
    return BlocProvider(
      create: (context) => di<OrdersBloc>()..add(GetOrdersEvent()),
      child: const OrderStoryPage(),
    );
  }

  @override
  State<OrderStoryPage> createState() => _OrderStoryPageState();
}

class _OrderStoryPageState extends State<OrderStoryPage> {
  String getStatus(String? status) {
    switch (status) {
      case 'new':
        return LocaleKeys.newStatus.tr();
      case 'cancelled':
        return LocaleKeys.cancelled.tr();
      case 'in_progress':
        return LocaleKeys.inProgress.tr();
      case 'done':
        return LocaleKeys.done.tr();
      default:
        return LocaleKeys.newStatus.tr();
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
          LocaleKeys.order_story_title.tr(),
          style: AppTextStyles.body18w6.copyWith(color: AppColors.mediumBlack),
        ),
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.mediumBlack.withOpacity(0.5)),
        ),
        elevation: 0,
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == OrdersStatus.failure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.error?.message ?? LocaleKeys.response_error.tr(),
                    style: AppTextStyles.body14w4,
                  ),
                  CustomButton(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    text: LocaleKeys.refresh.tr(),
                    onPressed: () {
                      context.read<OrdersBloc>().add(GetOrdersEvent());
                    },
                  ),
                ],
              ),
            );
          } else if (state.status == OrdersStatus.success) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemBuilder: (context, index) {
                var cardItem = state.cardsModel?[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [AppDecorations.defaultBoxShadow],
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${LocaleKeys.buyurtma_raqami.tr()} ${cardItem?.id}',
                          style: AppTextStyles.body16w5),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${LocaleKeys.buyurtma_holati.tr()}:',
                            style: AppTextStyles.body12w4
                                .copyWith(color: AppColors.grey1),
                          ),
                          Text(
                            getStatus(cardItem?.status),
                            style: AppTextStyles.body12w4
                                .copyWith(color: AppColors.grey1),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${LocaleKeys.phone.tr()}:',
                            style: AppTextStyles.body12w4
                                .copyWith(color: AppColors.grey1),
                          ),
                          const Spacer(),
                          Icon(Icons.phone,
                              size: 16.sp, color: AppColors.grey1),
                          Text(
                            '${cardItem?.phoneNumber?.phone}',
                            style: AppTextStyles.body12w4
                                .copyWith(color: AppColors.grey1),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${LocaleKeys.total_price.tr()}:',
                            style: AppTextStyles.body12w6,
                          ),
                          Text(
                            '${cardItem?.totalPrice?.formatAsNum()} ${LocaleKeys.som.tr()}',
                            style: AppTextStyles.body12w6,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      InkWell(
                        onTap: () {
                          context.goNamed(Routes.orderDetail, extra: cardItem);
                        },
                        child: Container(
                          height: 48.h,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.orange),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          child: Text(
                            LocaleKeys.more.tr(),
                            style: AppTextStyles.body14w6
                                .copyWith(color: AppColors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: state.cardsModel?.length ?? 0,
            );
          } else if (state.status == OrdersStatus.empty) {
            return Center(
              child: Text(
                LocaleKeys.info_not_found.tr(),
                style: AppTextStyles.body14w4,
              ),
            );
          }

          return Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
                size: 40.w, color: AppColors.orange),
          );
        },
      ),
    );
  }
}
