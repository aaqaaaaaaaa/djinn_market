import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/update_card_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/data/models/fav_product_model.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/delete_favourite_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/get_favourites_usescase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'favourites_event.dart';

part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final GetFavouritesUsescase getFavUsescase;
  final DeleteFavouriteUsescase deleteFavouriteUsescase;
  final UpdateCardsUsesCase updateCardsUsesCase;

  FavouritesBloc({
    required this.getFavUsescase,
    required this.deleteFavouriteUsescase,
    required this.updateCardsUsesCase,
  }) : super(FavouritesState.initial()) {
    on<GetFavouritesEvent>(getFavouritesEvent);
    on<UpdateFavCardEvent>(updateFavCardEvent);
    on<DeleteFavCardEvent>(deleteFavCardEvent);
  }

  void getFavouritesEvent(
      GetFavouritesEvent event, Emitter<FavouritesState> emit) async {
    emit(state.asLoading());

    try {
      final failureOrSearch = await getFavUsescase(GetFavouritesParams());
      failureOrSearch.fold(
        (error) => emit(state.asGetFavouritesFailure(error)),
        (data) async {
          if (data is List<FavProductModel>) {
            emit(state.asGetFavouritesSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asGetFavouritesFailure(e));
    }
  }

  void updateFavCardEvent(
      UpdateFavCardEvent event, Emitter<FavouritesState> emit) async {
    try {
      final failureOrSearch = await updateCardsUsesCase(UpdateCardsParams(
        id: event.id,
        productId: event.productId,
        amount: event.amount,
      ));
      print(event.amount);
      failureOrSearch.fold(
        (error) => emit(state.asUpdateCardsFailure(error)),
        (data) {
          emit(state.asUpdateCardsSuccess());
        },
      );
    } on Failure catch (e) {
      emit(state.asUpdateCardsFailure(e));
    }
  }

  void deleteFavCardEvent(
      DeleteFavCardEvent event, Emitter<FavouritesState> emit) async {
    try {
      final failureOrSuccess = await deleteFavouriteUsescase(
          DeleteFavouriteParams(productId: event.id));
      failureOrSuccess.fold(
        (error) => emit(state.asDeleteCardsFailure(error)),
        (data) {
          print('data');
          print(data);
          List<FavProductModel>? favs = [];
          for (int i = 0; i < (state.favModel?.length ?? 0); i++) {
            if (state.favModel?[i].product != event.id) {
              favs.add(state.favModel![i]);
            }
          }
          print(favs);
          emit(state.asDeleteCardsSuccess(favs));
        },
      );
    } on Failure catch (e) {
      emit(state.asDeleteCardsFailure(e));
    }
  }
}
