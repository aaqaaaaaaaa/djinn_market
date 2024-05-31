import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_childsection_model.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_section_model.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/repository/category_section_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasourse/category_section_remote_datasourse.dart';

class CategorySectionRepositoryImpl implements CategorySectionRepository {
  CategorySectionRemoteDataSourse categorySectionRemoteDataSourse;
  NetworkInfo networkInfo;

  CategorySectionRepositoryImpl(
      {required this.categorySectionRemoteDataSourse,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<CategorySectionModel>>> getAllSections(
      {required int categoryId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categorySectionRemoteDataSourse
            .getCategorySections(categoryId: categoryId);
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }

  @override
  Future<Either<Failure, List<ChildSectionModel>>> getAllChildSections(
      {required int sectionId, required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categorySectionRemoteDataSourse
            .getAllChildSections(sectionId: sectionId, page: page);
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure("message"));
      }
    } else {
      return const Left(ConnectionFailure("lost connection"));
    }
  }
}
