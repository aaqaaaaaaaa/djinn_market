import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/usecases/use_case.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_childsection_model.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/repository/category_section_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllChildSectionsUsecase
    extends UseCase<List<ChildSectionModel>, ChildSectionParams> {
  CategorySectionRepository repository;

  GetAllChildSectionsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<ChildSectionModel>>> call(
      ChildSectionParams params) async {
    return await repository.getAllChildSections(
      sectionId: params.sectionId,
      page: params.page,
    );
  }
}

class ChildSectionParams extends Equatable {
  final int sectionId, page;

  const ChildSectionParams({required this.page, required this.sectionId});

  @override
  List<Object?> get props => [];
}
