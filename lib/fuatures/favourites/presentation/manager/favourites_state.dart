part of 'favourites_bloc.dart';

enum FavouritesStatus {
  initial,
  loading,
  success,
  failure,
  updateSuccess,
  updateFailure,
  deleteSuccess,
  deleteFailure,
}

class FavouritesState {
  final FavouritesStatus status;
  final Failure? error;
  final String? message;
  final List<FavProductModel>? favModel;
  int favoritesPage;

  FavouritesState._({
    this.status = FavouritesStatus.initial,
    this.favoritesPage = 1,
    this.error,
    this.favModel,
    this.message,
  });

  FavouritesState.initial() : this._();

  FavouritesState asGetFavouritesSuccess(List<FavProductModel>? favs) {
    if (favs?.isNotEmpty ?? false) {
      favoritesPage++;
      return copyWith(
        status: FavouritesStatus.success,
        favModel: [...?favModel, ...?favs],
      );
    }
    return copyWith(
      status: FavouritesStatus.success,
      favModel: favModel,
    );
  }

  FavouritesState asUpdateCardsFailure(Failure failure) {
    return copyWith(status: FavouritesStatus.updateFailure, error: failure);
  }

  FavouritesState asUpdateCardsSuccess() {
    return copyWith(status: FavouritesStatus.updateSuccess);
  }

  FavouritesState asDeleteCardsFailure(Failure failure) {
    return copyWith(status: FavouritesStatus.deleteFailure, error: failure);
  }

  FavouritesState asDeleteCardsSuccess(List<FavProductModel>? favs) {
    return copyWith(status: FavouritesStatus.deleteSuccess,favModel: favs);
  }

  FavouritesState asGetFavouritesFailure(Failure failure) {
    return copyWith(status: FavouritesStatus.failure, error: failure);
  }

  FavouritesState asLoading() {
    return copyWith(status: FavouritesStatus.loading);
  }

  FavouritesState copyWith({
    FavouritesStatus? status,
    Failure? error,
    List<FavProductModel>? favModel,
    String? message,
  }) {
    return FavouritesState._(
      status: status ?? this.status,
      error: error ?? this.error,
      favModel: favModel ?? this.favModel,
      message: message,
    );
  }
}
