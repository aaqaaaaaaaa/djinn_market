part of 'category_bloc.dart';

enum CategoryStatus {
  initial,
  loading,
  productLoading,
  success,
  productRandomSuccess,
  createFavSuccess,
  deleteFavSuccess,
  addToCardSuccess,
  failure,
  createFavFailure,
  deleteFavFailure,
  addToCardFailure,
  bannersFailure,
  bannersSuccess,
  updateSuccess,
  updateFailure,
}

class CategoryState {
  final CategoryStatus? status;
  final Failure? error;
  final int? cardId;
  final String? message;
  final List<CategoryModel>? categories;
  final List<GetProductModel>? products;
  final List<CarouselBannersModel>? banners;

  CategoryState._({
    this.status = CategoryStatus.initial,
    this.error,
    this.cardId,
    this.categories,
    this.products,
    this.banners,
    this.message,
  });

  CategoryState.initial() : this._();

  CategoryState asGetRandomProductsSuccess(List<GetProductModel>? products) {
    if (products?.isNotEmpty ?? false) {
      return copyWith(
        status: CategoryStatus.productRandomSuccess,
        products: [...?this.products, ...?products],
      );
    }
    return copyWith(
      status: CategoryStatus.productRandomSuccess,
      products: this.products,
    );
  }

  CategoryState asGetProductsFailure(Failure failure) {
    return copyWith(status: CategoryStatus.failure, error: failure);
  }

  CategoryState asGetBannersFailure(Failure failure) {
    return copyWith(status: CategoryStatus.bannersFailure, error: failure);
  }

  CategoryState asGetBannersSuccess(List<CarouselBannersModel> banner) {
    return copyWith(
      status: CategoryStatus.bannersSuccess,
      banners: banner,
    );
  }

  CategoryState asCreateFavFailure(Failure failure) {
    return copyWith(status: CategoryStatus.createFavFailure, error: failure);
  }

  CategoryState asDeleteFavFailure(Failure failure) {
    return copyWith(status: CategoryStatus.deleteFavFailure, error: failure);
  }

  CategoryState asUpdateCardsFailure(Failure failure) {
    return copyWith(status: CategoryStatus.updateFailure, error: failure);
  }

  CategoryState asUpdateCardsSuccess() {
    return copyWith(status: CategoryStatus.updateSuccess);
  }

  CategoryState asDeleteFavSuccess() {
    return copyWith(status: CategoryStatus.deleteFavSuccess);
  }

  CategoryState asAddToCardFailure(Failure failure) {
    return copyWith(status: CategoryStatus.addToCardFailure, error: failure);
  }

  CategoryState asAddToCardSuccess(int cardId) {
    return copyWith(status: CategoryStatus.addToCardSuccess, cardId: cardId);
  }

  CategoryState asCreateFavSuccess() {
    return copyWith(status: CategoryStatus.createFavSuccess);
  }

  CategoryState asCategorySuccess(List<CategoryModel>? categories) {
    return copyWith(
      status: CategoryStatus.success,
      categories: categories,
    );
  }

  CategoryState asCategoryFailure(Failure failure) {
    return copyWith(status: CategoryStatus.failure, error: failure);
  }

  CategoryState asLoading() {
    return copyWith(
      status: CategoryStatus.loading,
    );
  }

  CategoryState asProductLoading() {
    return copyWith(status: CategoryStatus.productLoading);
  }

  CategoryState copyWith({
    CategoryStatus? status,
    Failure? error,
    int? cardId,
    List<CategoryModel>? categories,
    List<CarouselBannersModel>? banners,
    List<GetProductModel>? products,
    String? message,
  }) {
    return CategoryState._(
      status: status ?? this.status,
      error: error ?? this.error,
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      cardId: cardId,
      message: message,
    );
  }
}
