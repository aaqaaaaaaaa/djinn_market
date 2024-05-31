import 'package:bizda_bor/fuatures/profile/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';

class GetOrdersUsesCase extends UseCase<dynamic, GetOrdersParams> {
  final OrdersRepository repository;

  GetOrdersUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(GetOrdersParams params) {
    return repository.getOrders();
  }
}

class GetOrdersParams extends Equatable {
  @override
  List<Object?> get props => [];
}
