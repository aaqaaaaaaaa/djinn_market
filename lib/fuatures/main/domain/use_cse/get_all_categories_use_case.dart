import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:bizda_bor/fuatures/main/domain/repository/categories_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategoriesUseCase implements UseCase<List<CategoryModel>, Params> {
  final CategoriesRepository categoriesRepository;
  GetAllCategoriesUseCase({required this.categoriesRepository});
  @override
  Future<Either<Failure, List<CategoryModel>>> call(Params params) async {
    return await categoriesRepository.getAllCategories();
  }
}

class Params {}
