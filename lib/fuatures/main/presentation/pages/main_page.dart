import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/presentation/pages/login_page.dart';
import 'package:bizda_bor/fuatures/main/presentation/bloc/category/category_bloc.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/carousel_widget.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/categories_grid_widget.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/main_app_bar.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/product_grid_widget.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/pages/product_detail.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/error/failure.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static Widget screen() {
    return BlocProvider(
      create: (context) => di<CategoryBloc>()
        ..add(GetBannersEvent())
        ..add(GetAllCetgories())
        ..add(GetRandomProducts()),
      child: const MainPage(),
    );
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController controller = TextEditingController();
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MainAppBar(controller: controller),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state.status == CategoryStatus.success) {
            context.read<CategoryBloc>().add(GetRandomProducts());
          }
          if (state.status == CategoryStatus.failure) {
            if (state.error is UnautorizedFailure) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            }
          } else if (state.status == CategoryStatus.addToCardFailure) {
            Fluttertoast.showToast(
              msg: LocaleKeys.add_card_error.tr(),
              backgroundColor: AppColors.black.withOpacity(0.6),
            );
          } else if (state.status == CategoryStatus.addToCardSuccess) {
            Fluttertoast.showToast(
              msg: LocaleKeys.add_card_success.tr(),
              backgroundColor: AppColors.black.withOpacity(0.6),
            );
          }
        },
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: CarouselWidget(
                      imageList: state.banners, controller: carouselController),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: CategoriesGridWidget(
              //     isSeeAll: (state.categories?.length ?? 0) > 8,
              //     listCategories: state.categories,
              //     onNoConnection: () {
              //       context.read<CategoryBloc>()
              //         ..add(GetBannersEvent())
              //         ..add(GetRandomProducts());
              //     },
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 20.w, vertical: 10.h),
              //     child: PartTitleSeeAllWidget(
              //       title: LocaleKeys.popular_products.tr(),
              //       onSeeAll: () {},
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(
              //         horizontal: 20.w, vertical: 20.h),
              //     width: MediaQuery.of(context).size.width,
              //     // height: MediaQuery.of(context).size.height,
              //     child: GridView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         childAspectRatio: 160.w / 260.h,
              //         crossAxisSpacing: 20.w,
              //         mainAxisSpacing: 20.w,
              //       ),
              //       padding: EdgeInsets.zero,
              //       itemBuilder: (_, index) => InkWell(
              //           overlayColor: MaterialStateProperty.all(
              //               AppColors.transparent),
              //           onTap: () => Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => ProductDetail.screen(
              //                     id: state.products?[index].id,
              //                     childSectionId:
              //                         state.products?[index].childSectionId,
              //                   ),
              //                 ),
              //               ),
              //           child: ProductItemBody(
              //               onFavDeleted: (value) {},
              //               product: state.products?[index])),
              //       itemCount: state.products?.length ?? 0,
              //     ),
              //   ),
              // ),
            ],
            body: Stack(
              children: [
                Positioned.fill(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 150.h,
                    width: MediaQuery.of(context).size.width,
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async {
                        state.products?.clear();
                        context.read<CategoryBloc>().add(GetRandomProducts());
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent) {
                            PaintingBinding.instance.imageCache.clear();
                            context
                                .read<CategoryBloc>()
                                .add(GetRandomProducts());
                          }
                          return false;
                        },
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 160.w / 260.h,
                            crossAxisSpacing: 20.w,
                            mainAxisSpacing: 20.w,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          itemBuilder: (_, index) => InkWell(
                              overlayColor: MaterialStateProperty.all(
                                  AppColors.transparent),
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetail.screen(
                                        id: state.products?[index].id,
                                        childSectionId:
                                            state.products?[index].childSection,
                                        initModel: state.products?[index],
                                      ),
                                    ),
                                  ),
                              child: ProductItemBody(
                                  onFavDeleted: (value) {},
                                  product: state.products?[index])),
                          itemCount: state.products?.length ?? 0,
                        ),
                      ),
                    ),
                  ),
                ),
                if (state.status == CategoryStatus.productLoading)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30.h,
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: AppColors.orange, size: 40.w),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
