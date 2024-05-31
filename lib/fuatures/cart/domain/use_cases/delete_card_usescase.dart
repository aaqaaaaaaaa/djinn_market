import 'package:bizda_bor/fuatures/cart/domain/repositories/cards_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';

class DeleteCardsUsesCase extends UseCase<dynamic, DeleteCardsParams> {
  final CardsRepository repository;

  DeleteCardsUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(DeleteCardsParams params) {
    return repository.deleteCard(productId: params.productId);
  }
}

class DeleteCardsParams extends Equatable {
  final int? productId;

  const DeleteCardsParams({this.productId});

  @override
  List<Object?> get props => [];
}
