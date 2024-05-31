import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';

class GetCardsUsesCase extends UseCase<dynamic, GetCardsParams> {
  final CardsRepository repository;

  GetCardsUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(GetCardsParams params) {
    return repository.getCards(
      limit: params.limit,
      page: params.page,
      isOrdered: params.isOrdered,
    );
  }
}

class GetCardsParams extends Equatable {
  final bool? isOrdered;
  final int? page, limit;

  const GetCardsParams({this.isOrdered, this.page, this.limit});

  @override
  List<Object?> get props => [];
}
