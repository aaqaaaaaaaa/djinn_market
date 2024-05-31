import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/product_detail/data/datasourse/pr_detail_remote_datasourse.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/repository/pr_detail_repository.dart';
import 'package:dartz/dartz.dart';

class PrDetailRepositoryImpl implements PrDetailRepository {
  final PrDetailRemoteDataSourseImpl prDetailRemoteDataSourse;
  final NetworkInfo networkInfo;

  PrDetailRepositoryImpl(
      {required this.prDetailRemoteDataSourse, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getDetail({int? id}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await prDetailRemoteDataSourse.getDetail(id: id);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure("server Exception"));
      } catch (e) {
        return const Left(UnknownFailure('Unknown'));
      }
    } else {
      return const Left(ConnectionFailure("NoInternet"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> addToCard(
      {int? amount, bool? ordered, int? productId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await prDetailRemoteDataSourse.addToCard(
          productId: productId,
          amount: amount,
          ordered: ordered,
        );
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure("server Exception"));
      } on DioExceptions catch (e) {
        return Left(e.failure);
      }
    } else {
      return const Left(ConnectionFailure("NoInternet"));
    }
  }
}
