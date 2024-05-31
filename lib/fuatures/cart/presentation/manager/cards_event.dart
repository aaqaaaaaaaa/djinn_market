part of 'cards_bloc.dart';

@immutable
abstract class CardsEvent {}

class GetCardsEvent extends CardsEvent {
  final GetCardsParams params;

  GetCardsEvent({required this.params});
}

class DeleteCardEvent extends CardsEvent {
  final int? productId;

  DeleteCardEvent({this.productId});
}

class CreateOrderEvent extends CardsEvent {
  final CreateOrderModel? data;

  CreateOrderEvent({this.data});
}

class CreateLocationEvent extends CardsEvent {
  final CreateLocationParams? paramsData;

  CreateLocationEvent({this.paramsData});
}

class UpdateCardEvent extends CardsEvent {
  final int? id, amount, productId;

  UpdateCardEvent({this.id, this.amount, this.productId});
}
