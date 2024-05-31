import 'dart:convert';

import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/favourites/data/models/fav_product_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';

abstract class FavouritesRemoteDataSource {
  Future getFavourites();

  Future createFavourites({String? ball, int? userId, int? productId});

  Future deleteFavourites({int? productId});
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  Dio dio;

  FavouritesRemoteDataSourceImpl({required this.dio});

  @override
  Future getFavourites() async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData? user = box.get(UserData.boxKey);
      final response = await dio.request(
        "/favourites/",
        options: Options(
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user?.token}'
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<FavProductModel> listFavourites = (response.data as List)
            .map((model) => FavProductModel.fromJson(model))
            .toList();
        return listFavourites;
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }

  @override
  Future createFavourites({String? ball, int? userId, int? productId}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      var data = {"user": user.user?.id, "product": productId};
      print(data);
      final response = await dio.request("/favourites/create/",
          data: jsonEncode(data),
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }));
      print(response.data);
      if (response.statusCode == 201) {
        return 'success';
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      print('e=$e');
      print(failure);
      return failure;
    }
  }

  @override
  Future deleteFavourites({int? productId}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      final response = await dio.request(
        "/favourites/delete/?product_id=$productId",
        options: Options(
          method: 'GET',
          headers: {
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          },
        ),
      );

      if (response.statusCode == 200) {
        return 'success';
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }
}
