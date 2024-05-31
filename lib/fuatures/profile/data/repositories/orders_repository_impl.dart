import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/profile/data/data_sources/orders_remote_datasource.dart';
import 'package:bizda_bor/fuatures/profile/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRemoteDataSource ordersRemoteDataSource;
  NetworkInfo networkInfo;

  OrdersRepositoryImpl(
      {required this.ordersRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> getOrders() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await ordersRemoteDataSource.getOrders();
        print(result);
        return Right(result);
      } on DioException catch (e) {
        final failure = DioExceptions.fromDioError(e);
        print(failure.failure);
        return Left(failure.failure);
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }
}
