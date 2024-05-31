part of 'pr_detail_bloc.dart';

enum PrDetailStateStatus {
  initial,
  loading,
  similarLoading,
  success,
  failure,
  prSuccess,
  prFailure,
  addToCardLoading,
  addToCardSuccess,
  addToCardFailure,
  updateSuccess,
  updateFailure,
  deleteSuccess,
  deleteFailure,
}

class PrDetailState {
  final PrDetailStateStatus status;
  final ProductDetailModel? productDetailModel;
  final List<GetProductModel>? productModel;
  final Failure? error;
  final String? message;
  int productPage = 1;

  PrDetailState._({
    this.status = PrDetailStateStatus.initial,
    this.error,
    this.productModel,
    this.productPage = 1,
    this.productDetailModel,
    this.message,
  });

  PrDetailState.initial() : this._();

  PrDetailState asLoading() {
    return copyWith(status: PrDetailStateStatus.loading);
  }

  PrDetailState asSimilarLoading() {
    return copyWith(
      status: PrDetailStateStatus.similarLoading,
    );
  }

  PrDetailState asAddLoading() {
    return copyWith(
      status: PrDetailStateStatus.addToCardLoading,
    );
  }

  PrDetailState asSuccess(ProductDetailModel? prDetail) {
    return copyWith(
        status: PrDetailStateStatus.success, productDetailModel: prDetail);
  }

  PrDetailState asAddSuccess() {
    return copyWith(status: PrDetailStateStatus.addToCardSuccess);
  }

  PrDetailState asAddFailure(Failure failure) {
    return copyWith(
        status: PrDetailStateStatus.addToCardFailure, error: failure);
  }

  PrDetailState asFailure(Failure failure) {
    return copyWith(status: PrDetailStateStatus.failure, error: failure);
  }

  PrDetailState asProductSuccess(List<GetProductModel>? productModel) {
    if (productModel?.isNotEmpty ?? false) {
      productPage++;
      return copyWith(
          status: PrDetailStateStatus.prSuccess,
          productModel: [...?this.productModel, ...?productModel]);
    }
    return copyWith(
        status: PrDetailStateStatus.prSuccess, productModel: this.productModel);
  }

  PrDetailState asProductFailure(Failure failure) {
    return copyWith(status: PrDetailStateStatus.prFailure, error: failure);
  }

  PrDetailState asUpdateCardsFailure(Failure failure) {
    return copyWith(status: PrDetailStateStatus.updateFailure, error: failure);
  }

  PrDetailState asUpdateCardsSuccess() {
    return copyWith(status: PrDetailStateStatus.updateSuccess);
  }

  PrDetailState asDeleteCardsFailure(Failure failure) {
    return copyWith(status: PrDetailStateStatus.deleteFailure, error: failure);
  }

  PrDetailState asDeleteCardsSuccess() {
    return copyWith(status: PrDetailStateStatus.deleteSuccess);
  }

  PrDetailState copyWith({
    PrDetailStateStatus? status,
    Failure? error,
    ProductDetailModel? productDetailModel,
    List<GetProductModel>? productModel,
    String? message,
  }) {
    return PrDetailState._(
      status: status ?? this.status,
      error: error ?? this.error,
      productDetailModel: productDetailModel ?? this.productDetailModel,
      productModel: productModel ?? this.productModel,
      message: message,
    );
  }
}
