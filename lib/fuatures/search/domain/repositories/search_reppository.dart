import 'package:bizda_bor/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, dynamic>> search(
      {String? search, int? limit, int? page});
}
