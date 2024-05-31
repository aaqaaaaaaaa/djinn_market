import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class GetProductRemoteDataSource {
  Future<List<GetProductModel>?> getRandomProducts({int? limit});

  Future<List<GetProductModel>?> getProducts({int? limit, int? page, int? id});
}

class GetProductRemoteDataSourceImpl extends GetProductRemoteDataSource {
  Dio dio;

  GetProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GetProductModel>?> getProducts(
      {int? limit, int? page, int? id}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      print(user.token);
      final responce = await dio.request(
          id != null
              ? '/products/?child_section=$id&page=$page&page_size=$limit'
              : '/products/?page=$page&page_size=$limit',
          options: Options(method: 'GET', headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Token ${user.token}'
          }));
      if (responce.statusCode == 200) {
        List<GetProductModel> dataList = [];
        for (int i = 0; i < (responce.data['results'] as List).length; i++) {
          dataList.add(GetProductModel.fromJson(responce.data['results'][i]));
        }
        return dataList;
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      throw failure.failure;
    }
    return null;
  }

  @override
  Future<List<GetProductModel>?> getRandomProducts({int? limit}) async {
    try {
      final box = Hive.box(UserModel.boxKey);
      UserModel? user = box.get(UserModel.boxKey);
      final responce = await dio.request(
          '/products/random/?limit=$limit&user_id=${user?.id}',
          options: Options(method: 'GET', headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          }));
      if (responce.statusCode == 200) {
        List<GetProductModel> dataList = [];
        for (int i = 0; i < (responce.data as List).length; i++) {
          dataList.add(GetProductModel.fromJson(responce.data[i]));
        }
        return dataList;
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      throw failure.failure;
    }
    return null;
  }
}
