part of 'orders_bloc.dart';

enum OrdersStatus { initial, loading, success, empty, failure }

class OrdersState {
  final OrdersStatus status;
  final Failure? error;
  final String? message;
  final List<OrderModel>? cardsModel;

  OrdersState._({
    this.status = OrdersStatus.initial,
    this.error,
    this.cardsModel,
    this.message,
  });

  OrdersState.initial() : this._();

  OrdersState asGetOrdersSuccess(List<OrderModel>? cards) {
    if (cards?.isNotEmpty ?? false) {
      return copyWith(
        status: OrdersStatus.success,
        cardsModel: [...?cardsModel, ...?cards],
      );
    }
    return copyWith(
      status: OrdersStatus.success,
      cardsModel: cardsModel,
    );
  }

  OrdersState asGetOrdersFailure(Failure failure) {
    return copyWith(status: OrdersStatus.failure, error: failure);
  }

  OrdersState asLoading() {
    return copyWith(status: OrdersStatus.loading);
  }

  OrdersState asEmpty() {
    return copyWith(status: OrdersStatus.empty);
  }

  OrdersState copyWith({
    OrdersStatus? status,
    Failure? error,
    List<OrderModel>? cardsModel,
    String? message,
  }) {
    return OrdersState._(
      status: status ?? this.status,
      error: error ?? this.error,
      cardsModel: cardsModel ?? this.cardsModel,
      message: message,
    );
  }
}
