import 'package:bizda_bor/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class OrdersRepository {
  Future<Either<Failure, dynamic>> getOrders();
}
