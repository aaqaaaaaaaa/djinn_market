import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/di/di.dart';
import 'package:bizda_bor/fuatures/auth/data/data_sources/login_local_datasource.dart';
import 'package:bizda_bor/fuatures/auth/data/data_sources/login_remote_data_source.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/auth/domain/repositories/auth_reppository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSourceImpl;

  final AuthLocalDataSourceImpl localDataSourceImpl;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSourceImpl,
      required this.localDataSourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, String?>> login({String? phone}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.login(phone);

        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return const Left(ConnectionFailure("Connection error"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> confirmSms(
      {String? phone, String? code}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSourceImpl.confirmSms(phone: phone, code: code);
        if (result is UserData) {
          di<SharedPreferences>().setBool('has_user', true);
          localDataSourceImpl.setUser(result);
        } else {
          if (result is int) {
            di<SharedPreferences>().setInt('user_id', result);
          }
        }
        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return const Left(ConnectionFailure("Connection error"));
    }
  }

  @override
  Future<Either<Failure, dynamic>> register({
    String? fullName,
    String? adress,
    String? language,
    int? id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.register(
          id: id,
          adress: adress,
          language: language,
          fullName: fullName,
        );
        if (result is UserData) {
          di<SharedPreferences>().setBool('has_user', true);
          localDataSourceImpl.setUser(result);
        }
        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return const Left(ConnectionFailure("Connection error"));
    }
  }
}
