import 'package:bizda_bor/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/create_order_model.dart';

abstract class CardsRepository {
  Future<Either<Failure, dynamic>> getCards(
      {bool? isOrdered, int? page, int? limit});

  Future<Either<Failure, dynamic>> updateCard(
      {int? id, int? amount, int? productId});

  Future<Either<Failure, dynamic>> deleteCard({int? productId});

  Future<Either<Failure, dynamic>> createOrder({CreateOrderModel? data});

  Future<Either<Failure, dynamic>> createLocation(
      {num? lat, num? long, String? address});
}
