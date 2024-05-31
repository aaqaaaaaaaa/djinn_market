import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteFavouriteUsescase extends UseCase<dynamic, DeleteFavouriteParams> {
  final FavouritesRepository repository;

  DeleteFavouriteUsescase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(DeleteFavouriteParams params) {
    return repository.deleteFavourites(productId: params.productId);
  }
}

class DeleteFavouriteParams extends Equatable {
  final int? productId;

  const DeleteFavouriteParams({this.productId});

  @override
  List<Object?> get props => [];
}
