import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/search/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

abstract class SearchRemoteDataSource {
  Future<dynamic> search({String? search, int? limit, int? page});
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  Dio dio;

  SearchRemoteDataSourceImpl({required this.dio});

  @override
  Future search({String? search, int? limit, int? page}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      final responce = await dio.request(
          '/products?search=$search&page=$page&page_size=$limit',
          options: Options(method: 'GET', headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Token ${user.token}'
          }));
      if (responce.statusCode == 200) {
        List<ProductModel> dataList = [];
        for (int i = 0; i < (responce.data['results'] as List).length; i++) {
          dataList.add(ProductModel.fromJson(responce.data['results'][i]));
        }
        return dataList;
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure.failure;
    }
  }
}
