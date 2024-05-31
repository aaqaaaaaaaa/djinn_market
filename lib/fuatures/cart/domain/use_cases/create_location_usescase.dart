import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';

class CreateLocationUsesCase extends UseCase<dynamic, CreateLocationParams> {
  final CardsRepository repository;

  CreateLocationUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(CreateLocationParams params) {
    return repository.createLocation(
        address: params.address, lat: params.lat, long: params.long);
  }
}

class CreateLocationParams extends Equatable {
  final num? lat;
  final num? long;
  final String? address;

  const CreateLocationParams({this.address, this.lat, this.long});

  @override
  List<Object?> get props => [];
}
