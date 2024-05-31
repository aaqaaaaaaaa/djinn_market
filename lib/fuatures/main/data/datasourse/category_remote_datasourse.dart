import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/main/data/model/banner_model.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:dio/dio.dart';

abstract class CategoriesRemoteDataSourse {
  Future<List<CategoryModel>> getCategories();

  Future<List<CarouselBannersModel>> getBanners();
}

class CategoriesRemoteDataSourseImpl implements CategoriesRemoteDataSourse {
  Dio dio;

  CategoriesRemoteDataSourseImpl({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.request(
        "/categories/?is_active=true",
        options: Options(method: 'GET'));
    if (response.statusCode == 200) {
      print(response.data);
      final List<CategoryModel> listBanners = (response.data as List)
          .map((model) => CategoryModel.fromJson(model))
          .toList();
      return listBanners;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CarouselBannersModel>> getBanners() async {
    final response =
        await dio.request("/banners/", options: Options(method: 'GET'));
    if (response.statusCode == 200) {
      final List<CarouselBannersModel> listBanners =
          (response.data["results"] as List)
              .map((model) => CarouselBannersModel.fromJson(model))
              .toList();
      return listBanners;
    } else {
      throw ServerException();
    }
  }
}
