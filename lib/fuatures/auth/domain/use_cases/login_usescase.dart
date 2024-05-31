import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_reppository.dart';

class LoginUsesCase extends UseCase<dynamic, LoginParams> {
  final AuthRepository repository;

  LoginUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(LoginParams params) {
    return repository.login(phone: params.phone);
  }
}

class LoginParams extends Equatable {
  final String? phone;

  const LoginParams({this.phone});

  @override
  List<Object?> get props => [];
}
