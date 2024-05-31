import 'dart:async';

import 'package:bizda_bor/common/app_colors.dart';
import 'package:bizda_bor/common/app_text_style.dart';
import 'package:bizda_bor/common/assets.dart';
import 'package:bizda_bor/common/components/custom_textfield.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/search/presentation/manager/search_bloc.dart';
import 'package:bizda_bor/fuatures/search/presentation/widgets/search_bulim.dart';
import 'package:bizda_bor/fuatures/search/presentation/widgets/search_product_item.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchCon = TextEditingController();
  String filterValue = 'Popular';
  SharedPreferences? prefs;
  List<String> recentSearches = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs?.getStringList('recentSearch'));
  }

  void _onTextChanged(BuildContext context, String input) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      print('context.read<HomeBloc>().add(SearchUserEvent(query: input))');
      recentSearches.add(searchCon.text);
      prefs?.setStringList('recentSearch', recentSearches);
      context.read<SearchBloc>().add(OnSearchEvent(searchText: searchCon.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<SearchBloc>()..add(GetAllCetgoriesEvent()),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: PreferredSize(
              preferredSize: Size(
                MediaQuery.of(context).size.width,
                126.h,
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
                  child: CustomTextField(
                    controller: searchCon,
                    radius: 8.r,
                    height: 36.h,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    onSubmitted: (value) {
                      recentSearches.add(searchCon.text);
                      prefs?.setStringList('recentSearch', recentSearches);
                      context
                          .read<SearchBloc>()
                          .add(OnSearchEvent(searchText: searchCon.text));
                    },
                    onChanged: (value) => _onTextChanged(context, value),
                    borderColor: AppColors.transparent,
                    backgroundColor: AppColors.colorF2,
                    hintText: LocaleKeys.search_hint.tr(),
                    style: AppTextStyles.body14w4,
                    hintStyle: AppTextStyles.body14w4
                        .copyWith(color: AppColors.black.withOpacity(0.3)),
                    trailing: IconButton(
                      onPressed: () {
                        recentSearches.add(searchCon.text);
                        prefs?.setStringList('recentSearch', recentSearches);
                        context
                            .read<SearchBloc>()
                            .add(OnSearchEvent(searchText: searchCon.text));
                      },
                      padding: EdgeInsets.zero,
                      icon: Container(
                        width: 44.w,
                        height: 36.h,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10.r))),
                        child: SvgPicture.asset(Assets.icons.search,
                            width: 22.w, color: AppColors.orange),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: searchCon.text.isEmpty
                ? SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (prefs?.getStringList('recentSearch')?.isNotEmpty ??
                            false)
                          SearchBulimiWidget(
                            data: List.generate(
                              prefs?.getStringList('recentSearch')?.length ?? 0,
                              (index) => InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  searchCon.text = prefs?.getStringList(
                                          'recentSearch')?[index] ??
                                      '';
                                  context.read<SearchBloc>().add(OnSearchEvent(
                                      searchText: searchCon.text));
                                  setState(() {});
                                },
                                borderRadius: BorderRadius.circular(4.r),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.lightBlack.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(4.r)),
                                  child: Text(
                                      prefs?.getStringList(
                                              'recentSearch')?[index] ??
                                          '',
                                      style: AppTextStyles.body12w5),
                                ),
                              ),
                            ),
                            title: LocaleKeys.resent_search.tr(),
                          ),
                        // if (state.categories?.isNotEmpty ?? false)
                          // SearchBulimiWidget(
                          //   data: List.generate(
                          //     state.categories?.length ?? 0,
                          //     (index) => InkWell(
                          //       onTap: () {
                          //         FocusScope.of(context).unfocus();
                          //         searchCon.text =
                          //             context.locale.languageCode == 'ru'
                          //                 ? (state.categories?[index].nameRu ??
                          //                     state.categories?[index].nameUz ??
                          //                     '')
                          //                 : state.categories?[index].nameUz ??
                          //                     '';
                          //         context.read<SearchBloc>().add(OnSearchEvent(
                          //             searchText: searchCon.text));
                          //         setState(() {});
                          //       },
                          //       borderRadius: BorderRadius.circular(4.r),
                          //       child: Container(
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 8.w, vertical: 4.h),
                          //         decoration: BoxDecoration(
                          //             color:
                          //                 AppColors.lightBlack.withOpacity(0.3),
                          //             borderRadius: BorderRadius.circular(4.r)),
                          //         child: Text(
                          //             context.locale.languageCode == 'ru'
                          //                 ? (state.categories?[index].nameRu ??
                          //                     '')
                          //                 : state.categories?[index].nameUz ??
                          //                     '',
                          //             style: AppTextStyles.body12w5),
                          //       ),
                          //     ),
                          //   ),
                          //   title: LocaleKeys.categories.tr(),
                          // ),
                      ],
                    ),
                  )
                : (state.status == SearchStateStatus.loading)
                    ? Center(
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          size: 40.sp,
                          color: AppColors.orange,
                        ),
                      )
                    : (state.products?.isEmpty ?? true)
                        ? Center(
                            child: Text(LocaleKeys.info_not_found.tr()),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: CustomScrollView(
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          LocaleKeys.search_hint.tr().replaceAll(
                                              'count',
                                              '${state.products?.length ?? 0}'),
                                          style: AppTextStyles.head12wB,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return SearchProductItem(
                                          product: state.products?[index]);
                                    },
                                    childCount: state.products?.length ?? 0,
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(height: 28.h),
                                ),
                              ],
                            ),
                          ),
          );
        },
      ),
    );
  }
}
