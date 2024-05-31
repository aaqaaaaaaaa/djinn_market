import 'dart:async';

import 'package:bizda_bor/common/all_contants.dart';
import 'package:bizda_bor/common/components/custombutton.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:bizda_bor/fuatures/cart/presentation/widgets/pop_model.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class SearchAndPickMap extends StatefulWidget {
  const SearchAndPickMap({super.key, this.productList, this.totalPrice});

  final List<GetCardModel>? productList;
  final num? totalPrice;

  @override
  State<SearchAndPickMap> createState() => _SearchAndPickMapState();
}

class _SearchAndPickMapState extends State<SearchAndPickMap> {
  GeoPoint? geopoint;

  String address = '';
  late TextEditingController textEditingController = TextEditingController();
  late PickerMapController controller = PickerMapController(
    initPosition: geopoint,
    initMapWithUserPosition:
        const UserTrackingOption(enableTracking: true, unFollowUser: true),
  );

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.administrativeArea},  ${place.locality}, ${(place.thoroughfare != null && (place.thoroughfare?.isNotEmpty ?? false)) ? '${place.thoroughfare},' : ''} ${place.subThoroughfare}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      appBarPicker: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          LocaleKeys.address.tr(),
          style: AppTextStyles.body18w5.copyWith(color: AppColors.mediumBlack),
        ),
        leadingWidth: 60.w,
        leading: IconButton(
          onPressed: () => pop(context),
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.mediumBlack.withOpacity(0.5)),
        ),
        elevation: 0,
      ),
      controller: controller,
      bottomWidgetPicker: Positioned(
        bottom: 0,
        height: 200.h,
        child: SizedBox(
          height: 200.h,
          child: PointerInterceptor(
              child: Container(
            decoration: BoxDecoration(color: AppColors.backgroundColor),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Assets.icons.location),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: 275.w,
                        height: 60.h,
                        child: Text(
                          address == ''
                              ? LocaleKeys.check_address.tr()
                              : address,
                          style: AppTextStyles.body18w5,
                          maxLines: 3,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            controller.init();
                            setState(() {
                              address = '';
                              geopoint = null;
                            });
                          },
                          child: const Icon(Icons.close))
                    ],
                  ),
                ),
                Flexible(
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width,
                    buttonColor: AppColors.orange,
                    text: geopoint == null
                        ? LocaleKeys.check.tr()
                        : LocaleKeys.confirm.tr(),
                    onPressed: () async {
                      if (geopoint == null) {
                        GeoPoint p =
                            await controller.selectAdvancedPositionPicker();
                        setState(() => geopoint = p);
                        getAddressFromLatLong(Position(
                            longitude: geopoint?.longitude ?? 0,
                            latitude: geopoint?.latitude ?? 0,
                            timestamp: null,
                            accuracy: 0,
                            altitude: 0,
                            heading: 0,
                            speed: 0,
                            speedAccuracy: 0,
                            altitudeAccuracy: 0,
                            headingAccuracy: 0));
                      } else {
                        context.pop(
                            PopModel(geopoint: geopoint, address: address));
                      }
                    },
                  ),
                ),
                // SizedBox(height: 10.w),
                // Flexible(
                //   child: CustomButton(
                //     width: MediaQuery.of(context).size.width,
                //     buttonColor: AppColors.orange,
                //     text: LocaleKeys.confirm.tr(),
                //     onPressed: () async {
                //       if (geopoint != null) {
                //         context.pop(
                //             PopModel(geopoint: geopoint, address: address));
                //       } else {
                //         await Flushbar(
                //           flushbarPosition: FlushbarPosition.TOP,
                //           title: LocaleKeys.error.tr(),
                //           message: LocaleKeys.dont_check.tr(),
                //           duration: const Duration(seconds: 3),
                //         ).show(context);
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          )),
        ),
      ),
      pickerConfig: const CustomPickerLocationConfig(
        zoomOption: ZoomOption(initZoom: 16),
      ),
    );
  }
}
