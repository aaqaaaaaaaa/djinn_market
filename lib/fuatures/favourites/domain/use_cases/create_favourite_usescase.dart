import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/favourites/domain/repositories/favourites_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateFavouriteUsescase
    implements UseCase<dynamic, CreateFavouriteParams> {
  final FavouritesRepository repository;

  CreateFavouriteUsescase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(CreateFavouriteParams params) {
    return repository.createFavourites(
      ball: params.ball,
      userId: params.userId,
      productId: params.productId,
    );
  }
}

class CreateFavouriteParams extends Equatable {
  final String? ball;
  final int? userId;
  final int? productId;

  const CreateFavouriteParams({this.ball, this.userId, this.productId});

  @override
  List<Object?> get props => [];
}
