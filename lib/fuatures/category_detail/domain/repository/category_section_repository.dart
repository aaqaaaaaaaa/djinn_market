import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_childsection_model.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_section_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategorySectionRepository {
  Future<Either<Failure, List<CategorySectionModel>>> getAllSections(
      {required int categoryId});

  Future<Either<Failure, List<ChildSectionModel>>> getAllChildSections({
    required int sectionId,
    required int page,
  });
}
