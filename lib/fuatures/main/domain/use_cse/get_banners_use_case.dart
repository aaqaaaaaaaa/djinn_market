import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/main/data/model/banner_model.dart';
import 'package:bizda_bor/fuatures/main/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

class GetBannersUseCase implements UseCase<List<CarouselBannersModel>, GetBannersParams> {
  final CategoriesRepository repository;
  GetBannersUseCase({required this.repository});
  @override
  Future<Either<Failure, List<CarouselBannersModel>>> call(GetBannersParams params) async {
    return await repository.getBanners();
  }
}

class GetBannersParams {}
