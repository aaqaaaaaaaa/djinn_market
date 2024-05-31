import 'dart:convert';

import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/product_detail/data/model/product_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PrDetailRemoteDataSourse {
  Future<dynamic> getDetail({int? id});

  Future<dynamic> addToCard({
    int? amount,
    bool? ordered,
    int? productId,
  });
}

class PrDetailRemoteDataSourseImpl implements PrDetailRemoteDataSourse {
  Dio dio;

  PrDetailRemoteDataSourseImpl({required this.dio});

  @override
  Future<dynamic> getDetail({int? id}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      final responce = await dio.request('/products/$id/',
          options: Options(method: 'GET', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }));
      if (responce.statusCode == 200) {
        final result = ProductDetailModel.fromJson(responce.data);
        return result;
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }

  @override
  Future<dynamic> addToCard(
      {int? amount, bool? ordered, int? productId}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      print(user.token);
      print('''{
        "amount": $amount,
          "ordered": false,
          "product": $productId,
          "user": ${user.user?.id}
      }''');
      final responce = await dio.request('/cards/create/',
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }),
          data: jsonEncode({
            "amount": amount,
            "ordered": false,
            "product": productId,
            "user": user.user?.id
          }));
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        print(responce.data['id']);
        return responce.data['id'];
      }
    } on DioException catch (e) {
      print('e = $e');
      final failure = DioExceptions.fromDioError(e);
      print('failure = $failure');
      return failure;
    }
  }
}
