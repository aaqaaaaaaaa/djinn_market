import 'dart:convert';

import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<dynamic> login(String phone);

  Future<dynamic> confirmSms({String? phone, String? code});

  Future<dynamic> register({
    String? fullName,
    String? adress,
    String? language,
    int? id,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<dynamic> login(String? phone) async {
    var requestBody = {'phone': '$phone'};
    try {
      final responce = await dio.request('/app/auth/login/',
          data: requestBody, options: Options(method: 'POST'));
      if (responce.statusCode == 200) {
        return responce.data['code'];
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }

  @override
  Future confirmSms({String? phone, String? code}) async {
    try {
      final responce = await dio.request(
          '/app/auth/login/?phone=$phone&code=$code',
          options: Options(method: 'GET'));
      if (responce.statusCode == 200) {
        print(responce.data);
        if (responce.data['user'] == null) {
          print(responce.data);
          return responce.data['id'];
        }
        return UserData.fromJson(responce.data);
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      print(e);
      print(failure);
      return failure;
    }
  }

  @override
  Future register(
      {String? fullName, String? adress, String? language, int? id}) async {
    try {
      var data = {
        'id': id,
        'full_name': fullName,
        'language': language,
        'address': adress
      };
      final responce = await dio.request('/app/auth/login/',
          data: jsonEncode(data),
          options: Options(method: 'PUT', headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          }));
      if (responce.statusCode == 200) {
        print(responce.data);
        return UserData.fromJson(responce.data);
      }
    } on DioException catch (e) {
      final failure = DioExceptions.fromDioError(e);
      return failure;
    }
  }
}
///  keytool -genkey -v -keystore D:\androidProjects\bizda_bor\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload