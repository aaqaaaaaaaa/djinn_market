part of 'search_bloc.dart';

enum SearchStateStatus {
  initial,
  loading,
  searchSuccess,
  categorySuccess,
  failure,
  searchFailure,
}

class SearchState {
  final SearchStateStatus status;
  final Failure? error;
  final String? message;
  final List<ProductModel>? products;
  final List<CategoryModel>? categories;
  int? page = 1;

  SearchState._({
    this.status = SearchStateStatus.initial,
    this.error,
    this.page = 1,
    this.message,
    this.categories,
    this.products,
  });

  SearchState.initial() : this._();

  SearchState asLoading() {
    return copyWith(
      status: SearchStateStatus.loading,
    );
  }

  SearchState asCategoryFailure(Failure failure) {
    return copyWith(status: SearchStateStatus.failure, error: failure);
  }

  SearchState asCategorySuccess(List<CategoryModel>? categories) {
    return copyWith(
      status: SearchStateStatus.categorySuccess,
      categories: categories,
    );
  }

  SearchState asSearchSuccess(List<ProductModel> products) {
    if (products.isNotEmpty) {
      return copyWith(
          status: SearchStateStatus.searchSuccess,
          products: [...?this.products, ...products]);
    }
    return copyWith(
        status: SearchStateStatus.searchSuccess, products: this.products);
  }

  SearchState asSearchFailure(Failure failure) {
    return copyWith(status: SearchStateStatus.searchFailure, error: failure);
  }

  SearchState copyWith({
    SearchStateStatus? status,
    Failure? error,
    String? message,
    int? page,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
  }) {
    return SearchState._(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message,
      page: page ?? this.page,
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }
}
