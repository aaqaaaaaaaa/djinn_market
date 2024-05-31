import 'package:bizda_bor/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PrDetailRepository {
  Future<Either<Failure, dynamic>> getDetail({int? id});

  Future<Either<Failure, dynamic>> addToCard({
    int? amount,
    bool? ordered,
    int? productId,
  });
}
