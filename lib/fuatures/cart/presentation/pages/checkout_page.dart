import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/common/number_formatter.dart';
import 'package:bizda_bor/common/routes.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:bizda_bor/fuatures/cart/data/models/create_order_model.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/create_location_usescase.dart';
import 'package:bizda_bor/fuatures/cart/presentation/manager/cards_bloc.dart';
import 'package:bizda_bor/fuatures/cart/presentation/pages/search_and_pick_map.dart';
import 'package:bizda_bor/fuatures/cart/presentation/widgets/pop_model.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/pages/product_detail.dart';
import 'package:bizda_bor/fuatures/profile/data/models/order_model.dart';
import 'package:bizda_bor/fuatures/profile/presentation/widgets/order_detail_item_widget.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key, required this.productList, this.totalPrice = 0})
      : super(key: key);

  static Widget screen(List<GetCardModel>? productList, num? totalPrice) {
    return BlocProvider(
      create: (context) => di<CardsBloc>(),
      child: CheckOutPage(productList: productList, totalPrice: totalPrice),
    );
  }

  final List<GetCardModel>? productList;
  final num? totalPrice;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String? selectedOption = 'Naqt';

  // String address = '';
  GeoPoint? geopoint;
  PopModel? data;

  void onRadioChanged(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  double calculateDistance() {
    if (data != null) {
      double distance = Geolocator.distanceBetween(
        40.368547,
        71.770566,
        data?.geopoint?.latitude ?? 0,
        data?.geopoint?.longitude ?? 0,
      );
      return distance;
    }
    return 1;
  }

  @override
  Widget build(BuildContext bContext) {
    return BlocConsumer<CardsBloc, CardsState>(
      listener: (context, state) async {
        if (state.status == CardsStatus.createOrderSuccess) {
          context.pop();
          Fluttertoast.showToast(
            msg: LocaleKeys.order_successful.tr(),
            backgroundColor: AppColors.black.withOpacity(0.6),
          );
          context.goNamed(Routes.orderHistory);
        } else if (state.status == CardsStatus.loading) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: AppColors.orange, size: 40.w),
              );
            },
          );
        } else if (state.status == CardsStatus.createOrderFailure) {
          pop(context);
          Fluttertoast.showToast(
            msg: 'Sotib olishda xatolik yuz berdi!',
            backgroundColor: AppColors.black.withOpacity(0.6),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            centerTitle: true,
            title: Text(
              LocaleKeys.checkout.tr(),
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
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            // physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(LocaleKeys.address.tr(),
                      style: AppTextStyles.body17w5),
                ),
                InkWell(
                  onTap: () async {
                    data = await Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SearchAndPickMap(
                          productList: widget.productList,
                          totalPrice: widget.totalPrice,
                        );
                      },
                    ));
                    if (data != null) {
                      context.read<CardsBloc>().add(CreateLocationEvent(
                              paramsData: CreateLocationParams(
                            long: data?.geopoint?.longitude,
                            lat: data?.geopoint?.latitude,
                            address: data?.address,
                          )));
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Assets.icons.location),
                        Container(
                          width: MediaQuery.of(context).size.width - 120.w,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            data?.address ?? LocaleKeys.address.tr(),
                            style: AppTextStyles.body13w5,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        const Icon(CupertinoIcons.chevron_down),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${LocaleKeys.maxsulot_narxi.tr()}:',
                        style: AppTextStyles.body15w4
                            .copyWith(color: AppColors.mediumBlack),
                      ),
                      Text(
                        '${widget.totalPrice?.formatAsNum() ?? 0} ${LocaleKeys.som.tr()}',
                        style: AppTextStyles.body15w4
                            .copyWith(color: AppColors.mediumBlack),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        '${LocaleKeys.yetkazish_narxi.tr()}:',
                        style: AppTextStyles.body15w4
                            .copyWith(color: AppColors.mediumBlack),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    FittedBox(
                      child: Text(
                        '${data == null ? 0 : (calculateDistance() * 1.5).truncate().formatAsNum()} ${LocaleKeys.som.tr()}',
                        style: AppTextStyles.body15w4
                            .copyWith(color: AppColors.mediumBlack),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${LocaleKeys.total_price.tr()}:',
                        style: AppTextStyles.body17w5),
                    Text(
                        '${data == null ? 0 : ((calculateDistance() * 1.5).truncate() + (widget.totalPrice ?? 0)).formatAsNum()} ${LocaleKeys.som.tr()}',
                        style: AppTextStyles.body17w5),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  LocaleKeys.your_products.tr(),
                  style: AppTextStyles.body17w5,
                ),
                SizedBox(height: 10.h),
                ...List.generate(widget.productList?.length ?? 0, (index) {
                  return Column(
                    children: [
                      InkWell(
                          overlayColor:
                              MaterialStateProperty.all(AppColors.transparent),
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail.screen(
                                      id: widget.productList?[index].id ?? 0),
                                ),
                              ),
                          child: OrderDetailItemWidget(
                              product: Products(
                            amount: widget.productList?[index].amount,
                            id: widget.productList?[index].id,
                            price: widget.productList?[index].productPrice ?? 0,
                            nameUz: widget.productList?[index].productNameUz,
                            image: widget.productList?[index].productImage,
                            nameRu: widget.productList?[index].productNameUz,
                          ))),
                      if ((widget.productList?.length ?? 0) - 1 != index)
                        Divider(height: 12.h),
                    ],
                  );
                }),
                SizedBox(height: 100.h),
              ],
            ),
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: CustomButton(
              text: LocaleKeys.oformit_zakaz.tr(),
              onPressed: () {
                if (data?.address != null) {
                  context.read<CardsBloc>().add(
                        CreateOrderEvent(
                          data: CreateOrderModel(
                            totalPrice:
                                ((calculateDistance() * 1.5).truncate() +
                                    (widget.totalPrice ?? 0)),
                            paymentType: 'cash',
                            soldType: "mobile",
                            roadPrice: data == null
                                ? 0
                                : (calculateDistance() * 1.5).truncate(),
                            location: state.locationId,
                          ),
                        ),
                      );
                } else {
                  Fluttertoast.showToast(
                    msg: LocaleKeys.check_address.tr(),
                    backgroundColor: AppColors.black.withOpacity(0.6),
                  );
                }
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
