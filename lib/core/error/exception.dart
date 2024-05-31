import 'package:bizda_bor/core/error/failure.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class DioExceptions implements Exception {
  late Failure failure;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        failure = ConnectionFailure(dioError.response?.data['message']);
        break;
      case DioExceptionType.connectionTimeout:
        failure = ConnectionFailure(dioError.response?.data['message']);
        break;
      case DioExceptionType.receiveTimeout:
        failure = ConnectionFailure(dioError.response?.data['message']);

        break;
      case DioExceptionType.sendTimeout:
        failure = ConnectionFailure(dioError.response?.data['message']);
        break;
      case DioExceptionType.badResponse:
        failure = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.connectionError:
        failure = ConnectionFailure(dioError.response?.data['message']);
        break;
      case DioExceptionType.badCertificate:
        failure = BadResponceFailure(dioError.response?.data['message']);
        break;
      case DioExceptionType.unknown:
        failure = UnknownFailure(dioError.response?.data['message']);
        break;
      default:
        failure = UnknownFailure(dioError.response?.data['message']);
        break;
    }
  }

  Failure _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return BadResponceFailure(error['message']);
      case 401:
        return UnautorizedFailure(error['message']);
      case 403:
        return ForbiddenFailure(error['message']);
      case 404:
        return UrlNotFoundFailure(error['message']);
      case 500:
        return ServerFailure(error);
      case 502:
        return BadResponceFailure(error['message']);
      default:
        return UnknownFailure(error['message']);
    }
  }
}
