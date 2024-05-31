part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCetgories extends CategoryEvent {}

class GetRandomProducts extends CategoryEvent {}

class GetBannersEvent extends CategoryEvent {}

class UpdateCardEvent extends CategoryEvent {
  final int? id, amount, productId;

  const UpdateCardEvent({this.id, this.amount, this.productId});
}

class CreateFavouriteEvent extends CategoryEvent {
  final String? ball;
  final int? userId;
  final int? productId;

  const CreateFavouriteEvent({this.ball, this.userId, this.productId});
}

class DeleteFavouriteEvent extends CategoryEvent {
  final int? productId;

  const DeleteFavouriteEvent({this.productId});
}

class CategoryAddToCardEvent extends CategoryEvent {
  final int? productId;

  const CategoryAddToCardEvent({this.productId});
}
