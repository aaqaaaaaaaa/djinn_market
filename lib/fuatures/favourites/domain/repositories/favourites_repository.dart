import 'package:bizda_bor/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, dynamic>> getFavourites();

  Future<Either<Failure, dynamic>> createFavourites(
      {String? ball, int? userId, int? productId});

  Future<Either<Failure, dynamic>> deleteFavourites({int? productId});
}
