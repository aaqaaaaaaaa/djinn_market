import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/fuatures/main/data/model/banner_model.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryModel>>> getAllCategories();

  Future<Either<Failure, List<CarouselBannersModel>>> getBanners();
}
