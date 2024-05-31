import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_section_model.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/repository/category_section_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllSectionsUsecase extends UseCase<List<CategorySectionModel>, SectionParams> {
  CategorySectionRepository categorySectionRepository;
  GetAllSectionsUsecase({required this.categorySectionRepository});
  @override
  Future<Either<Failure, List<CategorySectionModel>>> call(SectionParams params) async {
    return await categorySectionRepository.getAllSections(
        categoryId: params.categoryId);
  }
}

class SectionParams {
  final int categoryId;
  SectionParams({required this.categoryId});
}
