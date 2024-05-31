import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/favourites/data/data_sources/favourites_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';

class FavouritesRepositoryImpl extends FavouritesRepository {
  final FavouritesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FavouritesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> createFavourites(
      {String? ball, int? userId, int? productId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.createFavourites(
            productId: productId, userId: userId, ball: ball);
        return Right(result);
      } on DioExceptions catch (e) {
        return Left(e.failure);
      }
    } else {
      return const Left(ConnectionFailure("NoInternet"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteFavourites({int? productId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.deleteFavourites(productId: productId);
        return Right(result);
      } on DioExceptions catch (e) {
        return Left(e.failure);
      }
    } else {
      return const Left(ConnectionFailure("NoInternet"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getFavourites() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getFavourites();
        return Right(result);
      } on DioExceptions catch (e) {
        return Left(e.failure);
      }
    } else {
      return const Left(ConnectionFailure("NoInternet"));
    }
  }
}
