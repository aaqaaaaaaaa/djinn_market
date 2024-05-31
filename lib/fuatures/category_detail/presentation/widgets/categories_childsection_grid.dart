import 'package:bizda_bor/fuatures/category_detail/data/model/category_childsection_model.dart';
import 'package:bizda_bor/fuatures/category_detail/presentation/widgets/category_section_item.dart';
import 'package:bizda_bor/fuatures/main/presentation/widgets/part_title.dart';
import 'package:bizda_bor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/all_contants.dart';

class CategoriesChildSectionGridWidget extends StatefulWidget {
  const CategoriesChildSectionGridWidget(
      {super.key, this.listSections, required this.onSelectedChanged});

  final ValueChanged<int> onSelectedChanged;
  final List<ChildSectionModel>? listSections;

  @override
  State<CategoriesChildSectionGridWidget> createState() =>
      _CategoriesChildSectionGridWidgetState();
}

class _CategoriesChildSectionGridWidgetState
    extends State<CategoriesChildSectionGridWidget> {
  bool isSeeAll = false;
  int itemsLength = 0;
  int selectedSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    itemsLength = widget.listSections?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PartTitleSeeAllWidget(
              title: LocaleKeys.child_sections.tr(),
              subtitle: (itemsLength >= 8)
                  ? isSeeAll
                      ? LocaleKeys.hide.tr()
                      : LocaleKeys.see_all.tr()
                  : null,
              onSeeAll: (itemsLength >= 8)
                  ? () {
                      isSeeAll = !isSeeAll;
                      if (isSeeAll) {
                        itemsLength = widget.listSections?.length ?? 0;
                      } else {
                        Future.delayed(
                          const Duration(milliseconds: 300),
                          () {
                            itemsLength =
                                (widget.listSections?.length ?? 0) >= 8
                                    ? 8
                                    : (widget.listSections?.length ?? 0);
                            setState(() {});
                          },
                        );
                      }
                      setState(() {});
                    }
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: MediaQuery.of(context).size.width,
            height: isSeeAll
                ? itemsLength > 8
                    ? 300.h
                    : 190.h
                : itemsLength >= 5
                    ? 190.h
                    : 100.h,
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
              itemCount: itemsLength,
              physics: isSeeAll
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.h,
                  mainAxisSpacing: 12.h),
              itemBuilder: (context, index) => InkWell(
                overlayColor: MaterialStateProperty.all(AppColors.transparent),
                onTap: () {
                  selectedSectionIndex = index;
                  widget.onSelectedChanged(index);
                  setState(() {});
                },
                child: CategorySectionItem(
                  isSelected: selectedSectionIndex == index,
                  sectionName: context.locale.languageCode == 'ru'
                      ? (widget.listSections?[index].nameRu)
                      : widget.listSections?[index].nameUz,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
