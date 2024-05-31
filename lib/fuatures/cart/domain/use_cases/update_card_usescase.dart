import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';

class UpdateCardsUsesCase extends UseCase<dynamic, UpdateCardsParams> {
  final CardsRepository repository;

  UpdateCardsUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(UpdateCardsParams params) {
    return repository.updateCard(
      id: params.id,
      productId: params.productId,
      amount: params.amount,
    );
  }
}

class UpdateCardsParams extends Equatable {
  final int? id, amount, productId;

  const UpdateCardsParams({this.id, this.amount, this.productId});

  @override
  List<Object?> get props => [];
}
