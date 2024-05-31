part of 'category_section_bloc.dart';

enum CategorySectionStatus {
  initial,
  loading,
  sectionSuccess,
  sectionFailure,
  childSectionLoading,
  childSectionSuccess,
  childSectionFailure,
  productLoading,
  productSuccess,
  productFailure,
}

class CategorySectionState {
  final CategorySectionStatus status;
  final Failure? error;
  final String? message;
  List<CategorySectionModel>? categorySectionList;
  List<ChildSectionModel>? childSectionList;
  List<GetProductModel>? products;

  CategorySectionState._({
    this.status = CategorySectionStatus.initial,
    this.error,
    this.message,
    this.products,
    this.categorySectionList,
    this.childSectionList,
  });

  CategorySectionState.initial() : this._();

  CategorySectionState asLoading() {
    return copyWith(
      status: CategorySectionStatus.loading,
    );
  }

  CategorySectionState asChildSectionLoading() {
    return copyWith(status: CategorySectionStatus.childSectionLoading);
  }

  CategorySectionState asProductsLoading() {
    return copyWith(status: CategorySectionStatus.productLoading);
  }

  CategorySectionState asChildSectionSuccess(
      List<ChildSectionModel> childSectionList) {
    if (childSectionList.isNotEmpty) {
      return copyWith(
          status: CategorySectionStatus.childSectionSuccess,
          childSectionList: [...?this.childSectionList, ...childSectionList]);
    }
    return copyWith(
      status: CategorySectionStatus.childSectionSuccess,
    );
  }

  CategorySectionState asChildSectionFailure(Failure failure) {
    return copyWith(
        status: CategorySectionStatus.childSectionFailure, error: failure);
  }

  CategorySectionState asProductsSuccess(List<GetProductModel> products) {
    if (products.isNotEmpty) {
      return copyWith(
          status: CategorySectionStatus.productSuccess,
          products: [...?this.products, ...products]);
    }
    return copyWith(status: CategorySectionStatus.productSuccess);
  }

  CategorySectionState asProductsFailure(Failure failure) {
    return copyWith(
        status: CategorySectionStatus.productFailure, error: failure);
  }

  CategorySectionState asSectionSuccess(
      List<CategorySectionModel> categorySectionList) {
    if (categorySectionList.isNotEmpty) {
      return copyWith(
          status: CategorySectionStatus.sectionSuccess,
          categorySectionList: [
            ...?this.categorySectionList,
            ...categorySectionList
          ]);
    }
    return copyWith(
      status: CategorySectionStatus.sectionSuccess,
    );
  }

  CategorySectionState asSectionFailure(Failure failure) {
    return copyWith(
        status: CategorySectionStatus.sectionFailure, error: failure);
  }

  CategorySectionState copyWith({
    CategorySectionStatus? status,
    Failure? error,
    List<ChildSectionModel>? childSectionList,
    List<CategorySectionModel>? categorySectionList,
    List<GetProductModel>? products,
    String? message,
    String? code,
    int? userId,
  }) {
    return CategorySectionState._(
      status: status ?? this.status,
      error: error ?? this.error,
      categorySectionList: categorySectionList ?? this.categorySectionList,
      products: products ?? this.products,
      childSectionList: childSectionList ?? this.childSectionList,
      message: message,
    );
  }
}
