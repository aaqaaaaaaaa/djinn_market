import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetFavouritesUsescase implements UseCase<dynamic, GetFavouritesParams> {
  final FavouritesRepository repository;

  GetFavouritesUsescase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(GetFavouritesParams params) {
    return repository.getFavourites();
  }
}

class GetFavouritesParams extends Equatable {
  @override
  List<Object?> get props => [];
}
