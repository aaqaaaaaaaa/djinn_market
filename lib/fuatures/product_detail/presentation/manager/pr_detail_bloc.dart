import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/update_card_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/delete_favourite_usescase.dart';
import 'package:bizda_bor/fuatures/product_detail/data/model/product_detail_model.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/use_cse/add_to_card_usescase.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/use_cse/pr_detail_usescase.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:bizda_bor/services/get_products/domain/use_cases/get_product_usescase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';

part 'pr_detail_event.dart';
part 'pr_detail_state.dart';

class PrDetailBloc extends Bloc<PrDetailEvent, PrDetailState> {
  final PrDetailUseCase prDetailUseCase;
  final GetProductUsesCase getProductUsesCase;
  final AddToCardUseCase addToCardUseCase;

  final DeleteFavouriteUsescase deleteFavouriteUsescase;
  final UpdateCardsUsesCase updateCardsUsesCase;
  PrDetailBloc({
    required this.prDetailUseCase,
    required this.addToCardUseCase,
    required this.getProductUsesCase,
    required this.deleteFavouriteUsescase,
    required this.updateCardsUsesCase,
  }) : super(PrDetailState.initial()) {
    on<GetPrDetailEvent>(getPrDetailEvent);
    on<GetProductEvent>(getProductEvent);
    on<AddToCardProductEvent>(addToCardProductEvent);
    // on<CreateFavouriteEvent>(createFavouriteEvent);
    // on<DeleteFavouriteEvent>(deleteFavCardEvent);
  }



  // void createFavouriteEvent(
  //     CreateFavouriteEvent event, Emitter<PrDetailState> emit) async {
  //   try {
  //     final failureOrSearch = await updateCardsUsesCase(UpdateCardsParams(
  //       id: event.id,
  //       productId: event.productId,
  //       amount: event.amount,
  //     ));
  //     print(event.amount);
  //     failureOrSearch.fold(
  //           (error) => emit(state.asUpdateCardsFailure(error)),
  //           (data) {
  //         emit(state.asUpdateCardsSuccess());
  //       },
  //     );
  //   } on Failure catch (e) {
  //     emit(state.asUpdateCardsFailure(e));
  //   }
  // }

  // void deleteFavCardEvent(
  //     DeleteFavCardEvent event, Emitter<PrDetailState> emit) async {
  //   try {
  //     final failureOrSuccess = await deleteFavouriteUsescase(
  //         DeleteFavouriteParams(productId: event.id));
  //     failureOrSuccess.fold(
  //           (error) => emit(state.asDeleteCardsFailure(error)),
  //           (data) {
  //         emit(state.asDeleteCardsSuccess());
  //       },
  //     );
  //   } on Failure catch (e) {
  //     emit(state.asDeleteCardsFailure(e));
  //   }
  // }
  void getPrDetailEvent(
      GetPrDetailEvent event, Emitter<PrDetailState> emit) async {
    emit(state.asLoading());
    try {
      final failureOrSignUp =
          await prDetailUseCase(PrDetailParams(id: event.id));
      failureOrSignUp.fold(
        (error) => emit(state.asFailure(error)),
        (data) async {
          if (data is DioExceptions) {
            emit(state.asFailure(data.failure));
          } else if (data is ProductDetailModel) {
            emit(state.asSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asFailure(e));
    }
  }

  void addToCardProductEvent(
      AddToCardProductEvent event, Emitter<PrDetailState> emit) async {
    emit(state.asAddLoading());
    try {
      final failureOrSignUp = await addToCardUseCase(AddToCardParams(
        amount: event.params?.amount,
        productId: event.params?.productId,
        ordered: event.params?.ordered,
      ));
      failureOrSignUp.fold(
        (error) => emit(state.asAddFailure(error)),
        (data) async {
          if (data is DioExceptions) {
            emit(state.asAddFailure(data.failure));
          } else {
            emit(state.asAddSuccess());
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asAddFailure(e));
    }
  }

  void getProductEvent(
      GetProductEvent event, Emitter<PrDetailState> emit) async {
    emit(state.asSimilarLoading());
    try {
      final failureOrSignUp = await getProductUsesCase(GetProductParams(
          childSection: event.id, page: state.productPage, limit: 10));
      failureOrSignUp.fold(
        (error) => emit(state.asFailure(error)),
        (data) async {
          emit(state.asProductSuccess(data));
        },
      );
    } on Failure catch (e) {
      emit(state.asFailure(e));
    }
  }
}
