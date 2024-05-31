import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/repository/pr_detail_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddToCardUseCase implements UseCase<dynamic, AddToCardParams> {
  final PrDetailRepository repository;

  AddToCardUseCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(AddToCardParams params) async {
    return await repository.addToCard(
      productId: params.productId,
      amount: params.amount,
      ordered: params.ordered,
    );
  }
}

class AddToCardParams extends Equatable {
  final int? amount;
  final bool? ordered;
  final int? productId;

  const AddToCardParams(
      {this.amount, this.ordered, this.productId});

  @override
  List<Object?> get props => [];
}
