part of 'cards_bloc.dart';

enum CardsStatus {
  initial,
  loading,
  success,
  deleteSuccess,
  createOrderSuccess,
  createOrderFailure,
  createOrderLoading,
  updateSuccess,
  failure,
  deleteLoading,
  deleteFailure,
  updateFailure,
  createLocationFailure,
  createLocationSuccess,
}

class CardsState {
  final CardsStatus status;
  final Failure? error;
  final String? message;
  final List<GetCardModel>? cardsModel;
  int cardsPage;
  int locationId;
  int? cardId;

  CardsState._({
    this.status = CardsStatus.initial,
    this.cardsPage = 1,
    this.locationId = 0,
    this.cardId = 0,
    this.error,
    this.cardsModel,
    this.message,
  });

  CardsState.initial() : this._();

  CardsState asGetCardsSuccess(List<GetCardModel>? cards) {
    if (cards?.isNotEmpty ?? false) {
      cardsPage++;
      return copyWith(
        status: CardsStatus.success,
        cardsModel: [...?cardsModel, ...?cards],
      );
    }
    return copyWith(
      status: CardsStatus.success,
      cardsModel: cardsModel,
    );
  }

  CardsState asGetCardsFailure(Failure failure) {
    return copyWith(status: CardsStatus.failure, error: failure);
  }

  CardsState deleteCardsSuccess() {
    return copyWith(status: CardsStatus.deleteSuccess);
  }

  CardsState asCreateOrderSuccess(int? cardId) {
    return copyWith(status: CardsStatus.createOrderSuccess, cardId: cardId);
  }

  CardsState asCreateOrderFailure(Failure? failure) {
    return copyWith(status: CardsStatus.createOrderFailure, error: failure);
  }

  CardsState asCreateOrderLoading() {
    return copyWith(status: CardsStatus.createOrderLoading);
  }

  CardsState asLoading() {
    return copyWith(status: CardsStatus.loading);
  }

  CardsState asDeleteLoading() {
    return copyWith(status: CardsStatus.deleteLoading);
  }

  CardsState deleteCardsFailure(Failure failure) {
    return copyWith(status: CardsStatus.deleteFailure, error: failure);
  }

  CardsState asUpdateCardsFailure(Failure failure) {
    return copyWith(status: CardsStatus.updateFailure, error: failure);
  }

  CardsState asUpdateCardsSuccess() {
    return copyWith(status: CardsStatus.updateSuccess);
  }

  CardsState asCreateLocationFailure(Failure failure) {
    return copyWith(status: CardsStatus.createLocationFailure, error: failure);
  }

  CardsState asCreateLocationSuccess(int? locationId) {
    print(locationId);
    return copyWith(
        status: CardsStatus.createLocationSuccess, locationId: locationId);
  }

  CardsState copyWith({
    CardsStatus? status,
    Failure? error,
    int? locationId,
    int? cardId,
    List<GetCardModel>? cardsModel,
    String? message,
  }) {
    return CardsState._(
      status: status ?? this.status,
      error: error ?? this.error,
      locationId: locationId ?? this.locationId,
      cardsModel: cardsModel ?? this.cardsModel,
      message: message,
      cardId: cardId,
    );
  }
}
