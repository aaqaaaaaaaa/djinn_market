import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_reppository.dart';

class ConfirmSmsUsesCase extends UseCase<dynamic, ConfirmSmsParams> {
  final AuthRepository repository;

  ConfirmSmsUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(ConfirmSmsParams params) {
    return repository.confirmSms(phone: params.phone, code: params.code);
  }
}

class ConfirmSmsParams extends Equatable {
  final String? phone;
  final String? code;

  const ConfirmSmsParams({this.code, this.phone});

  @override
  List<Object?> get props => [];
}
