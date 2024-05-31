import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/update_card_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/create_favourite_usescase.dart';
import 'package:bizda_bor/fuatures/favourites/domain/use_cases/delete_favourite_usescase.dart';
import 'package:bizda_bor/fuatures/main/data/model/banner_model.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:bizda_bor/fuatures/main/domain/use_cse/get_all_categories_use_case.dart';
import 'package:bizda_bor/fuatures/main/domain/use_cse/get_banners_use_case.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/use_cse/add_to_card_usescase.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:bizda_bor/services/get_products/domain/use_cases/get_random_product_usescase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetRandomProductUsesCase getProductUsesCase;
  final GetBannersUseCase getBannersUseCase;
  final CreateFavouriteUsescase createFavUsescase;
  final DeleteFavouriteUsescase deleteFavUsescase;
  final AddToCardUseCase addToCardUseCase;
  final UpdateCardsUsesCase updateCardsUsesCase;

  CategoryBloc({
    required this.getProductUsesCase,
    required this.createFavUsescase,
    required this.getBannersUseCase,
    required this.deleteFavUsescase,
    required this.updateCardsUsesCase,
    required this.addToCardUseCase,
    required this.getAllCategoriesUseCase,
  }) : super(CategoryState.initial()) {
    on<GetRandomProducts>(getProducts);
    on<CreateFavouriteEvent>(createFavouriteEvent);
    on<DeleteFavouriteEvent>(deleteFavouriteEvent);
    on<CategoryAddToCardEvent>(categoryAddToCardEvent);
    on<GetBannersEvent>(getBannersEvent);
    on<UpdateCardEvent>(updateCardsEvent);
    on<GetAllCetgories>(
      (event, emit) async {
        emit(state.asLoading());
        final allCategories = await getAllCategoriesUseCase(Params());
        allCategories.fold(
          (l) {
            if (l is DioExceptions) {
              emit(state.asCategoryFailure(l));
            } else {
              emit(state.asCategoryFailure(l));
            }
          },
          (r) => emit(state.asCategorySuccess(r)),
        );
      },
    );
  }

  void updateCardsEvent(
      UpdateCardEvent event, Emitter<CategoryState> emit) async {
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

  void getBannersEvent(
      GetBannersEvent event, Emitter<CategoryState> emit) async {
    emit(state.asLoading());

    try {
      final failureOrSearch = await getBannersUseCase(GetBannersParams());
      failureOrSearch.fold(
        (error) => emit(state.asGetBannersFailure(error)),
        (data) async {
          emit(state.asGetBannersSuccess(data));
        },
      );
    } on Failure catch (e) {
      emit(state.asGetProductsFailure(e));
    }
  }

  void getProducts(GetRandomProducts event, Emitter<CategoryState> emit) async {
    emit(state.asProductLoading());

    try {
      final failureOrSearch =
          await getProductUsesCase(const GetProductParams(limit: 10));
      failureOrSearch.fold(
        (error) => emit(state.asGetProductsFailure(error)),
        (data) async {
          if (data is List<GetProductModel>) {
            emit(state.asGetRandomProductsSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asGetProductsFailure(e));
    }
  }

  void deleteFavouriteEvent(
      DeleteFavouriteEvent event, Emitter<CategoryState> emit) async {
    try {
      final failureOrSearch = await deleteFavUsescase(
          DeleteFavouriteParams(productId: event.productId));
      failureOrSearch.fold(
        (error) => emit(state.asDeleteFavFailure(error)),
        (data) {
          emit(state.asDeleteFavSuccess());
        },
      );
    } on DioExceptions catch (e) {
      emit(state.asDeleteFavFailure(e.failure));
    }
  }

  void categoryAddToCardEvent(
      CategoryAddToCardEvent event, Emitter<CategoryState> emit) async {
    try {
      final failureOrSearch = await addToCardUseCase(AddToCardParams(
          amount: 1, ordered: false, productId: event.productId));
      failureOrSearch.fold(
        (error) => emit(state.asAddToCardFailure(error)),
        (data) {
          emit(state.asAddToCardSuccess(data));
        },
      );
    } on DioExceptions catch (e) {
      emit(state.asAddToCardFailure(e.failure));
    }
  }

  void createFavouriteEvent(
      CreateFavouriteEvent event, Emitter<CategoryState> emit) async {
    try {
      final failureOrSearch = await createFavUsescase(CreateFavouriteParams(
        productId: event.productId,
        userId: event.userId,
        ball: event.ball,
      ));
      failureOrSearch.fold(
        (error) => emit(state.asCreateFavFailure(error)),
        (data) {
          emit(state.asCreateFavSuccess());
        },
      );
    } on DioExceptions catch (e) {
      emit(state.asCreateFavFailure(e.failure));
    }
  }
}
