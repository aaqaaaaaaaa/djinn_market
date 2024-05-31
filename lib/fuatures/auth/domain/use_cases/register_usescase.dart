import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_reppository.dart';

class RegisterUsesCase extends UseCase<dynamic, RegisterParams> {
  final AuthRepository repository;

  RegisterUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(RegisterParams params) {
    return repository.register(
      id: params.id,
      adress: params.adress,
      language: params.language,
      fullName: params.fullName,
    );
  }
}

class RegisterParams extends Equatable {
  final String? fullName;
  final String? adress, language;

  final int? id;

  const RegisterParams({
    this.fullName,
    this.language,
    this.adress,
    this.id,
  });

  @override
  List<Object?> get props => [];
}
