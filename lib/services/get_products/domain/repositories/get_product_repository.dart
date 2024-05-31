import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class GetProductRepository {
  Future<Either<Failure, List<GetProductModel>?>> getRandomProducts(
      {int? limit});

  Future<Either<Failure, List<GetProductModel>?>> getProducts(
      {int? limit, int? childSection, int? page});
}
