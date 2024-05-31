import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/fuatures/profile/data/models/order_model.dart';
import 'package:bizda_bor/fuatures/profile/domain/use_cases/get_orders_usescase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUsesCase getOrdersUsesCase;

  OrdersBloc({
    required this.getOrdersUsesCase,
  }) : super(OrdersState.initial()) {
    on<GetOrdersEvent>(getOrdersEvent);
  }

  void getOrdersEvent(GetOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(state.asLoading());

    try {
      final failureOrSearch = await getOrdersUsesCase(GetOrdersParams());
      failureOrSearch.fold(
        (error) => emit(state.asGetOrdersFailure(error)),
        (data) async {
          if (data is List<OrderModel>) {
            if (data.isEmpty) {
              emit(state.asEmpty());
            } else {
              emit(state.asGetOrdersSuccess(data));
            }
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asGetOrdersFailure(e));
    }
  }
}
