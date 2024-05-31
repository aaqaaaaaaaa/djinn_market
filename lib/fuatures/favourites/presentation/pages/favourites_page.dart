import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/favourites/presentation/manager/favourites_bloc.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/part_title.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/product_grid_widget.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../product_detail/presentation/pages/product_detail.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  static Widget screen() {
    return BlocProvider(
      create: (context) => di<FavouritesBloc>()..add(GetFavouritesEvent()),
      child: const FavouritesPage(),
    );
  }

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          LocaleKeys.favurites.tr(),
          style: AppTextStyles.body18w5.copyWith(color: AppColors.mediumBlack),
        ),
        // leadingWidth: 60.w,
        // leading: IconButton(
        //   onPressed: () => context.goNamed(Routes.mainPage),
        //   icon: Icon(Icons.arrow_back_ios,
        //       color: AppColors.mediumBlack.withOpacity(0.5)),
        // ),
        elevation: 0,
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state.status == FavouritesStatus.loading) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                size: 40.sp,
                color: AppColors.orange,
              ),
            );
          } else if (state.status == FavouritesStatus.failure) {
            return Center(
              child: Text(
                state.error?.message ?? LocaleKeys.unknown_error.tr(),
                style: AppTextStyles.body16w5,
              ),
            );
          } else if (state.status == FavouritesStatus.deleteSuccess) {
            print(selectedId);
            state.favModel?.removeWhere((element) => element.id == selectedId);
          } else if (state.status == FavouritesStatus.success ||
              state.status == FavouritesStatus.updateSuccess ||
              state.status == FavouritesStatus.updateFailure) {
            if (state.favModel == null || (state.favModel?.isEmpty ?? false)) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    LocaleKeys.favourite_empty.tr(),
                    style: AppTextStyles.body16w5,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: PartTitleSeeAllWidget(
                      title:
                          '${LocaleKeys.fav_products.tr()} (${state.favModel?.length ?? 0})',
                      onSeeAll: () {},
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 160.w / 260.h,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 20.w,
                      ),
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) => InkWell(
                        overlayColor:
                            MaterialStateProperty.all(AppColors.transparent),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail.screen(
                                id: state.favModel?[index].id),
                          ),
                        ),
                        child: ProductItemBody(
                          onFavDeleted: (value) {
                            if (value != null) {
                              selectedId = value;
                              setState(() {});
                            }
                          },
                          favId: state.favModel?[index].product,
                          product: GetProductModel(
                              amount: 0,
                              id: state.favModel?[index].id,
                              price: state.favModel?[index].price,
                              image: state.favModel?[index].image,
                              compressImage:
                                  state.favModel?[index].compressImage,
                              nameUz: state.favModel?[index].nameUz,
                              nameRu: state.favModel?[index].nameRu,
                              convert: 'uzs',
                              isFavourite: true),
                        ),
                      ),
                      itemCount: state.favModel?.length ?? 0,
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              size: 40.sp,
              color: AppColors.orange,
            ),
          );
        },
      ),
    );
  }
}
