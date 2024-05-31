import 'package:bizda_bor/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String?>> login({String? phone});

  Future<Either<Failure, dynamic>> confirmSms({String? phone, String? code});

  Future<Either<Failure, dynamic>> register({
    String? fullName,
    String? adress,
    String? language,
    int? id,
  });
}
