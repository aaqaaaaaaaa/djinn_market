import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/services/get_products/data/data_sources/get_product_remote_data_source.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/get_product_repository.dart';

class GetProductRepositoryImpl extends GetProductRepository {
  final GetProductRemoteDataSourceImpl remoteDataSourceImpl;

  final NetworkInfo networkInfo;

  GetProductRepositoryImpl(
      {required this.remoteDataSourceImpl, required this.networkInfo});

  @override
  Future<Either<Failure, List<GetProductModel>?>> getRandomProducts(
      {int? limit}) async {

    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSourceImpl.getRandomProducts(limit: limit);
        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return const Left(ConnectionFailure("Connection error"));
    }
  }

  @override
  Future<Either<Failure, List<GetProductModel>?>> getProducts(
      {int? limit, int? childSection, int? page}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getProducts(
            limit: limit, page: page, id: childSection);
        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return const Left(ConnectionFailure("Connection error"));
    }
  }
}
