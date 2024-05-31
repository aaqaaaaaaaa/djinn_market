part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent {}

class GetFavouritesEvent extends FavouritesEvent {}

class UpdateFavCardEvent extends FavouritesEvent {
  final int? id, amount, productId;

  UpdateFavCardEvent({this.id, this.amount, this.productId});
}

class DeleteFavCardEvent extends FavouritesEvent {
  final int? id;

  DeleteFavCardEvent({this.id});
}
