import 'package:bizda_bor/fuatures/cart/data/models/create_order_model.dart';
import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';

class CreateOrderUsesCase extends UseCase<dynamic, CreateOrderParams> {
  final CardsRepository repository;

  CreateOrderUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(CreateOrderParams params) {
    return repository.createOrder(data: params.data);
  }
}

class CreateOrderParams extends Equatable {
  final CreateOrderModel? data;

  const CreateOrderParams({this.data});

  @override
  List<Object?> get props => [];
}
