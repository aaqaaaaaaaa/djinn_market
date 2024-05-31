import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/cart/data/models/card_model.dart';
import 'package:bizda_bor/fuatures/cart/data/models/create_order_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CardRemoteDatasourse {
  Future<dynamic> getCards(
      {int? userId, bool? isOrdered, int? page, int? limit});

  Future<dynamic> updateCard({int? id, int? amount, int? productId});

  Future<dynamic> deleteCard({int? productId});

  Future<dynamic> createOrder({CreateOrderModel? data});

  Future<dynamic> createLocation({num? lat, num? long, String? address});
}

class CardRemoteDatasourseImpl implements CardRemoteDatasourse {
  Dio dio;

  CardRemoteDatasourseImpl({required this.dio});

  @override
  Future deleteCard({int? productId}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      final responce = await dio.request(
        '/cards/$productId/delete/',
        options: Options(method: 'DELETE', headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Token ${user.token}'
        }),
      );

      if (responce.statusCode == 204) {
        return responce.statusCode;
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      print(failure.failure);
      return failure;
    }
  }

  @override
  Future<dynamic> getCards(
      {int? userId, bool? isOrdered, int? page, int? limit}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      final responce = await dio.request(
          '/cards/?user=${user.user?.id}&ordered=$isOrdered&page=$page&page_size=$limit',
          options: Options(method: 'GET', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }));
      if (responce.statusCode == 200) {
        print(responce.data);
        List<GetCardModel> data = [];
        for (int i = 0; i < (responce.data['results'] as List).length; i++) {
          data.add(GetCardModel.fromJson(responce.data['results'][i]));
        }
        print(data);
        return data;
      }
    } on DioException catch (e) {
      print(e);
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }

  @override
  Future createLocation({num? lat, num? long, String? address}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      final responce = await dio.request('/locations/create/',
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }),
          data: {
            "latitude": lat,
            "longitude": long,
            "address": address,
            "user": user.user?.id
          });
      if (responce.statusCode == 201) {
        print(responce.data['id']);
        return responce.data['id'];
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }

  @override
  Future updateCard({int? id, int? amount, int? productId}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      print('''
      {
            "amount": $amount,
            "product": $productId,
            "user": ${user.user?.id}
          }
      ''');

      final responce = await dio.request('/cards/$id/update/',
          options: Options(method: 'PUT', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }),
          data: {
            "amount": amount,
            "product": productId,
            "user": user.user?.id
          });
      if (responce.statusCode == 200) {
        print(responce.data);
        return 'ok';
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }

  @override
  Future createOrder({CreateOrderModel? data}) async {
    try {
      final box = Hive.box(UserData.boxKey);
      UserData user = box.get(UserData.boxKey);
      data?.userId = user.user?.id;
      print(data?.userId);
      final responce = await dio.request('/orders/android/',
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Token ${user.token}'
          }),
          data: data?.toJson());
      if (responce.statusCode == 200) {
        return responce.data['id'];
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }
}
