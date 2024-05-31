import 'package:bizda_bor/core/error/failure.dart';
import 'package:bizda_bor/core/platform/network_info.dart';
import 'package:bizda_bor/fuatures/search/data/data_sources/search_remote_data_source.dart';
import 'package:bizda_bor/fuatures/search/domain/repositories/search_reppository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSourceImpl remoteDataSourceImpl;

  final NetworkInfo networkInfo;

  SearchRepositoryImpl(
      {required this.remoteDataSourceImpl, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> search(
      {String? search, int? limit, int? page}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.search(
            limit: limit, page: page, search: search);
        return Right(result);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return const Left(ConnectionFailure("Connection error"));
    }
  }
}
