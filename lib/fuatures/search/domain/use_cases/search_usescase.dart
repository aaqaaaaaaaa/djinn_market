import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/search_reppository.dart';

class SearchUsesCase extends UseCase<dynamic, SearchParams> {
  final SearchRepository repository;

  SearchUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(SearchParams params) {
    return repository.search(
      search: params.search,
      limit: params.limit,
      page: params.page,
    );
  }
}

class SearchParams extends Equatable {
  final String? search;
  final int? limit, page;

  const SearchParams({this.search, this.limit, this.page});

  @override
  List<Object?> get props => [];
}
