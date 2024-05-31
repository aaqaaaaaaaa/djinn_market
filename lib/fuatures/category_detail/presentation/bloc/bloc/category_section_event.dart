part of 'category_section_bloc.dart';

abstract class CategorySectionEvent {}

class GetCategorySectionList extends CategorySectionEvent {
  final int categoryId;

  GetCategorySectionList({required this.categoryId});
}

class GetChildSectionEvent extends CategorySectionEvent {
  final int sectionId;

  GetChildSectionEvent({required this.sectionId});
}

class GetProductsChildSectionEvent extends CategorySectionEvent {
  final int childSectionId;

  GetProductsChildSectionEvent({required this.childSectionId});
}
