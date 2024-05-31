import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_childsection_model.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_section_model.dart';
import 'package:dio/dio.dart';

abstract class CategorySectionRemoteDataSourse {
  Future<List<CategorySectionModel>> getCategorySections(
      {required int categoryId});

  Future<List<ChildSectionModel>> getAllChildSections({
    required int sectionId,
    required int page,
  });
}

class CategorySectionRemoteDataSourseImpl
    implements CategorySectionRemoteDataSourse {
  Dio dio;

  CategorySectionRemoteDataSourseImpl({required this.dio});

  @override
  Future<List<CategorySectionModel>> getCategorySections(
      {required int categoryId}) async {
    final response = await dio.request(
        "/sections/?category=$categoryId",
        options: Options(method: 'GET'));
    if (response.statusCode == 200) {
      List<CategorySectionModel> list = [];
      for (int i = 0; i < (response.data["results"] as List).length; i++) {
        list.add(CategorySectionModel.fromJson(response.data['results'][i]));
      }
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ChildSectionModel>> getAllChildSections(
      {required int sectionId, required int page}) async {
    final response = await dio.request(
        "/child-sections?section=$sectionId&page_size=30&page=$page",
        options: Options(method: 'GET'));
    if (response.statusCode == 200) {
      List<ChildSectionModel> list = [];
      for (int i = 0; i < (response.data["results"] as List).length; i++) {
        list.add(ChildSectionModel.fromJson(response.data['results'][i]));
      }
      return list;
    } else {
      throw ServerException();
    }
  }
}
