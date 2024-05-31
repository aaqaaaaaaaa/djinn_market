import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:bizda_bor/fuatures/cart/data/models/create_order_model.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/create_location_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/create_order_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/delete_card_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/get_cards_usescase.dart';
import 'package:bizda_bor/fuatures/cart/domain/use_cases/update_card_usescase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cards_event.dart';

part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final GetCardsUsesCase getCardsUsesCase;
  final UpdateCardsUsesCase updateCardsUsesCase;
  final DeleteCardsUsesCase deleteCardsUsesCase;
  final CreateOrderUsesCase createOrderUsesCase;
  final CreateLocationUsesCase createLocationUsesCase;

  CardsBloc({
    required this.getCardsUsesCase,
    required this.updateCardsUsesCase,
    required this.createOrderUsesCase,
    required this.createLocationUsesCase,
    required this.deleteCardsUsesCase,
  }) : super(CardsState.initial()) {
    on<GetCardsEvent>(getCardsEvent);
    on<UpdateCardEvent>(updateCardsEvent);
    on<DeleteCardEvent>(deleteCardsEvent);
    on<CreateOrderEvent>(createOrderEvent);
    on<CreateLocationEvent>(createLocationEvent);
  }

  void getCardsEvent(GetCardsEvent event, Emitter<CardsState> emit) async {
    emit(state.asLoading());

    try {
      final failureOrSearch = await getCardsUsesCase(GetCardsParams(
        limit: 30,
        isOrdered: event.params.isOrdered,
        page: state.cardsPage,
      ));
      failureOrSearch.fold(
        (error) => emit(state.asGetCardsFailure(error)),
        (data) async {
          if (data is List<GetCardModel>) {
            emit(state.asGetCardsSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asGetCardsFailure(e));
    }
  }

  void createOrderEvent(
      CreateOrderEvent event, Emitter<CardsState> emit) async {
    emit(state.asLoading());

    try {
      final failureOrSearch =
          await createOrderUsesCase(CreateOrderParams(data: event.data));
      failureOrSearch.fold(
        (error) => emit(state.asCreateOrderFailure(error)),
        (data) async {

          emit(state.asCreateOrderSuccess(data));
        },
      );
    } on Failure catch (e) {
      emit(state.asCreateOrderFailure(e));
    }
  }

  void createLocationEvent(
      CreateLocationEvent event, Emitter<CardsState> emit) async {
    try {
      final failureOrSearch = await createLocationUsesCase(CreateLocationParams(
        lat: event.paramsData?.lat,
        address: event.paramsData?.address,
        long: event.paramsData?.long,
      ));
      failureOrSearch.fold(
        (error) => emit(state.asCreateLocationFailure(error)),
        (data) async {
          if (data is int) {
            emit(state.asCreateLocationSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asCreateLocationFailure(e));
    }
  }

  void updateCardsEvent(UpdateCardEvent event, Emitter<CardsState> emit) async {
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

  void deleteCardsEvent(DeleteCardEvent event, Emitter<CardsState> emit) async {
    emit(state.asDeleteLoading());

    try {
      final failureOrSearch = await deleteCardsUsesCase(DeleteCardsParams(
        productId: event.productId,
      ));
      failureOrSearch.fold(
        (error) => emit(state.asUpdateCardsFailure(error)),
        (data) {
          print('data');
          print(data);
          emit(state.asUpdateCardsSuccess());
        },
      );
    } on Failure catch (e) {
      emit(state.asUpdateCardsFailure(e));
    }
  }
}
