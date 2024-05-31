import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_decorations.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/pages/product_detail.dart';
import 'package:bizda_bor/fuatures/profile/data/models/order_model.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/order_detail_item_widget.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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
            LocaleKeys.order_detail.tr(),
            style:
                AppTextStyles.body18w5.copyWith(color: AppColors.mediumBlack),
          ),
          leadingWidth: 60.w,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios,
                color: AppColors.mediumBlack.withOpacity(0.5)),
          ),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [AppDecorations.defaultBoxShadow],
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${LocaleKeys.buyurtma_raqami.tr()} ${widget.orderModel.id}',
                  style: AppTextStyles.body16w5),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.buyurtma_holati.tr()}:',
                    style:
                        AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
                  ),
                  Text(
                    getStatus(widget.orderModel.status),
                    style:
                        AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.yetkazish_narxi.tr()}:',
                    style:
                        AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
                  ),
                  Text(
                    '${widget.orderModel.roadPrice?.formatAsNum()} ${LocaleKeys.som.tr()}',
                    style:
                        AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Yetkazigan vaqt:',
              //       style:
              //           AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
              //     ),
              //     Text(
              //       '${widget.orderModel.endTime}'.formatDate(),
              //       //23.09.23 14:39
              //       style:
              //           AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Telefon raqam:',
              //       style:
              //           AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
              //     ),
              //     const Spacer(),
              //     Icon(Icons.phone, size: 16.sp, color: AppColors.grey1),
              //     Text(
              //       '${widget.orderModel.phoneNumber?.phone}',
              //       style:
              //           AppTextStyles.body12w4.copyWith(color: AppColors.grey1),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.total_price.tr()}:',
                    style: AppTextStyles.body12w5,
                  ),
                  Text(
                    '${widget.orderModel.totalPrice?.formatAsNum()} ${LocaleKeys.som.tr()}',
                    style: AppTextStyles.body12w5,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(LocaleKeys.products.tr(),
                    style: AppTextStyles.body16w5),
              ),
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 12.h),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => InkWell(
                      overlayColor:
                          MaterialStateProperty.all(AppColors.transparent),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail.screen(
                                  id: widget.orderModel.products?[index].id ??
                                      0),
                            ),
                          ),
                      child: OrderDetailItemWidget(
                          product: widget.orderModel.products?[index])),
                  itemCount: widget.orderModel.products?.length ?? 0,
                ),
              ),
            ],
          ),
        ));
  }
}
