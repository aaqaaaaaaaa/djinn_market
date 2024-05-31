import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/main/data/datasourse/category_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/main/data/model/banner_model.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:bizda_bor/fuatures/main/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRemoteDataSourse categoriesRemoteDataSourse;
  NetworkInfo networkInfo;

  CategoriesRepositoryImpl(
      {required this.categoriesRemoteDataSourse, required this.networkInfo});

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categoriesRemoteDataSourse.getCategories();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure("server Exception"));
      } catch (e) {
        return const Left(UnknownFailure('Unknown'));
      }
    } else {
      return Left(ConnectionFailure("NoInternet"));
    }
  }

  @override
  Future<Either<Failure, List<CarouselBannersModel>>> getBanners() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categoriesRemoteDataSourse.getBanners();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure("server Exception"));
      } catch (e) {
        return const Left(UnknownFailure('Unknown'));
      }
    } else {
      return Left(ConnectionFailure("NoInternet"));
    }
  }
}
