part of 'pr_detail_bloc.dart';

@immutable
abstract class PrDetailEvent {}

class GetPrDetailEvent extends PrDetailEvent {
  final int? id;

  GetPrDetailEvent({this.id});
}

class GetProductEvent extends PrDetailEvent {
  final int? id;

  GetProductEvent({this.id});
}

class AddToCardProductEvent extends PrDetailEvent {
  final AddToCardParams? params;

  AddToCardProductEvent({this.params});
}

class CreateFavouriteEvent extends PrDetailEvent {
  final String? ball;
  final int? userId;
  final int? productId;

  CreateFavouriteEvent({this.ball, this.userId, this.productId});
}

class DeleteFavouriteEvent extends PrDetailEvent {
  final int? productId;

  DeleteFavouriteEvent({this.productId});
}
