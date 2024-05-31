import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/get_product_repository.dart';

class GetProductUsesCase
    extends UseCase<List<GetProductModel>?, GetProductParams> {
  final GetProductRepository repository;

  GetProductUsesCase({required this.repository});

  @override
  Future<Either<Failure, List<GetProductModel>?>> call(
      GetProductParams params) {
    return repository.getProducts(
      limit: params.limit,
      page: params.page,
      childSection: params.childSection,
    );
  }
}

class GetProductParams extends Equatable {
  final int? limit, page, childSection;

  const GetProductParams({this.page, this.childSection, this.limit});

  @override
  List<Object?> get props => [];
}
