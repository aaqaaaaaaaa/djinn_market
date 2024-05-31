import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/bloc/bloc/category_section_bloc.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/widgets/categories_childsection_grid.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/widgets/categories_section_grid_widget.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/part_title.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/product_grid_widget.dart';
import 'package:bizda_bor/fuatures/product_detail/presentation/pages/product_detail.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({Key? key, required this.categoryModel})
      : super(key: key);
  final CategoryModel? categoryModel;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  int selectedSectionIndex = 0;
  int selectedChildSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CategorySectionBloc>()
        ..add(
            GetCategorySectionList(categoryId: widget.categoryModel?.id ?? 0)),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(
            '${context.locale.languageCode == 'ru' ? widget.categoryModel?.nameRu : widget.categoryModel?.nameUz}',
            style:
                AppTextStyles.body18w6.copyWith(color: AppColors.mediumBlack),
          ),
          leadingWidth: 60.w,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios,
                color: AppColors.mediumBlack.withOpacity(0.5)),
          ),
          elevation: 0,
        ),
        body: BlocConsumer<CategorySectionBloc, CategorySectionState>(
          listener: (context, state) {
            if (state.status == CategorySectionStatus.sectionSuccess) {
              context.read<CategorySectionBloc>().add(GetChildSectionEvent(
                  sectionId:
                      state.categorySectionList?[selectedSectionIndex].id ??
                          0));
            } else if (state.status ==
                CategorySectionStatus.childSectionSuccess) {
              selectedChildSectionIndex = 0;
              context.read<CategorySectionBloc>().add(
                  GetProductsChildSectionEvent(
                      childSectionId: state
                              .childSectionList?[selectedChildSectionIndex]
                              .id ??
                          0));
            }
          },
          builder: (context, state) {
            if (state.status == CategorySectionStatus.loading) {
              return Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: AppColors.orange, size: 40.w));
            }
            return CustomScrollView(
              slivers: [
                if (state.categorySectionList?.isNotEmpty ?? false)
                  SliverToBoxAdapter(
                    child: CategoriesSectionGridWidget(
                      onSelectedChanged: (value) {
                        selectedSectionIndex = value;
                        selectedChildSectionIndex = 0;
                        state.childSectionList?.clear();
                        state.products?.clear();
                        context.read<CategorySectionBloc>().add(
                            GetChildSectionEvent(
                                sectionId: state
                                        .categorySectionList?[
                                            selectedSectionIndex]
                                        .id ??
                                    0));
                      },
                      listSections: state.categorySectionList,
                    ),
                  )
                else
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height - 60.h,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        LocaleKeys.info_not_found.tr(),
                        style: AppTextStyles.body14w4,
                      ),
                    ),
                  ),
                if (state.status == CategorySectionStatus.childSectionLoading)
                  SliverToBoxAdapter(
                    child: Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: AppColors.orange, size: 40.w),
                    ),
                  )
                else if (state.childSectionList?.isNotEmpty ?? false)
                  SliverToBoxAdapter(
                    child: CategoriesChildSectionGridWidget(
                        onSelectedChanged: (value) {
                          selectedChildSectionIndex = value;

                          state.products?.clear();
                          setState(() {});
                          context.read<CategorySectionBloc>().add(
                              GetProductsChildSectionEvent(
                                  childSectionId: state
                                          .childSectionList?[
                                              selectedChildSectionIndex]
                                          .id ??
                                      0));
                        },
                        listSections: state.childSectionList),
                  ),
                if (state.status == CategorySectionStatus.productLoading)
                  SliverToBoxAdapter(
                      child: Center(
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                              color: AppColors.orange, size: 40.w)))
                else if (state.products?.isNotEmpty ?? false)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: PartTitleSeeAllWidget(
                        title: context.locale.languageCode == 'ru'
                            ? (state
                                .childSectionList?[selectedChildSectionIndex]
                                .nameRu)
                            : state.childSectionList?[selectedChildSectionIndex]
                                .nameUz,
                        onSeeAll: () {},
                      ),
                    ),
                  ),
                if (state.products?.isNotEmpty ?? false)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
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
                        itemBuilder: (context, index) => InkWell(
                            overlayColor: MaterialStateProperty.all(
                                AppColors.transparent),
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail.screen(
                                      id: state.products?[index].id,
                                      childSectionId:
                                          state.products?[index].childSection,
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
              ],
            );
            // }
            // return const Center(child: Text('is empty'));
          },
        ),
      ),
    );
  }
}

// SliverToBoxAdapter(
//   child: Padding(
//     padding: EdgeInsets.symmetric(
//         horizontal: 20.w, vertical: 25.h),
//     child: Column(
//       children: [
//         PartTitleSeeAllWidget(
//           title: 'Most Popular',
//           onSeeAll: () {},
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: GridView.builder(
//             itemCount: 4,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate:
//                 SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 12.w,
//                     childAspectRatio: 161 / 231,
//                     crossAxisSpacing: 12.w),
//             itemBuilder: (context, index) => InkWell(
//               overlayColor: MaterialStateProperty.all(
//                   AppColors.transparent),
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProductDetail(),
//                 ),
//               ),
//               child: Container(
//                 height: 250.h,
//                 width: 161.w,
//                 padding: EdgeInsets.all(12.w),
//                 decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(8.r),
//                     boxShadow: [
//                       AppDecorations.defaultBoxShadow
//                     ]),
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                         height: 108.h,
//                         child: Image.asset(
//                             Assets.images.defaultImage)),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 12.h),
//                       child: Text(
//                         'Samsung 4K LED Ultarafine Tv',
//                         maxLines: 2,
//                         style: AppTextStyles.body12w4
//                             .copyWith(
//                                 color: AppColors.fullBlack),
//                       ),
//                     ),
//                     Text(
//                       '\$140.00',
//                       maxLines: 1,
//                       style: AppTextStyles.body10w4.copyWith(
//                           decoration:
//                               TextDecoration.lineThrough,
//                           color: AppColors.mediumBlack),
//                     ),
//                     FittedBox(
//                       child: Row(
//                         children: [
//                           Text(
//                             '\$320.00 ',
//                             maxLines: 1,
//                             style: AppTextStyles.body16w6
//                                 .copyWith(
//                                     color:
//                                         AppColors.fullBlack),
//                           ),
//                           Text(
//                             '-30%',
//                             maxLines: 1,
//                             style: AppTextStyles.body10w4
//                                 .copyWith(
//                                     color:
//                                         AppColors.thinkColor),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   ),
// ),
// SliverToBoxAdapter(
//   child: Padding(
//     padding: EdgeInsets.only(
//         left: 20.w, right: 20.w, bottom: 25.h),
//     child: Column(
//       children: [
//         PartTitleSeeAllWidget(
//           title: 'Brand',
//           onSeeAll: () {},
//         ),
//       ],
//     ),
//   ),
// ),
