import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/cart/data/data_sources/card_remote_datasource.dart';
import 'package:bizda_bor/fuatures/cart/data/models/create_order_model.dart';
import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class CardsRepositoryImpl implements CardsRepository {
  CardRemoteDatasourse cardsRemoteDataSource;
  NetworkInfo networkInfo;

  CardsRepositoryImpl(
      {required this.cardsRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> deleteCard({int? productId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await cardsRemoteDataSource.deleteCard(productId: productId);
        print('result');
        print(result);
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getCards(
      {bool? isOrdered, int? page, int? limit}) async {
    final box = Hive.box(UserModel.boxKey);
    UserModel? user = box.get(UserModel.boxKey);
    if (await networkInfo.isConnected) {
      try {
        final result = await cardsRemoteDataSource.getCards(
          userId: user?.id,
          page: page,
          isOrdered: isOrdered,
          limit: limit,
        );
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateCard(
      {int? id, int? amount, int? productId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cardsRemoteDataSource.updateCard(
          id: id,
          amount: amount,
          productId: productId,
        );
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> createLocation(
      {num? lat, num? long, String? address}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cardsRemoteDataSource.createLocation(
          address: address,
          lat: lat,
          long: long,
        );
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> createOrder({CreateOrderModel? data}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cardsRemoteDataSource.createOrder(data: data);
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }
}
