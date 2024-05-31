import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/get_product_repository.dart';

class GetRandomProductUsesCase
    extends UseCase<List<GetProductModel>?, GetProductParams> {
  final GetProductRepository repository;

  GetRandomProductUsesCase({required this.repository});

  @override
  Future<Either<Failure, List<GetProductModel>?>> call(
      GetProductParams params) {
    return repository.getRandomProducts(
      limit: params.limit,
    );
  }
}

class GetProductParams extends Equatable {
  final int? limit;

  const GetProductParams({this.limit});

  @override
  List<Object?> get props => [];
}
