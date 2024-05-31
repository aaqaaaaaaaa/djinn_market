import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/product_detail/domain/repository/pr_detail_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PrDetailUseCase implements UseCase<dynamic, PrDetailParams> {
  final PrDetailRepository categoriesRepository;

  PrDetailUseCase({required this.categoriesRepository});

  @override
  Future<Either<Failure, dynamic>> call(PrDetailParams params) async {
    return await categoriesRepository.getDetail(id: params.id);
  }
}

class PrDetailParams extends Equatable {
  final int? id;

  const PrDetailParams({this.id});

  @override
  List<Object?> get props => [];
}
