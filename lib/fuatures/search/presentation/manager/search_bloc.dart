import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/main/data/model/categories_model.dart';
import 'package:bizda_bor/fuatures/main/domain/use_cse/get_all_categories_use_case.dart';
import 'package:bizda_bor/fuatures/search/data/models/product_model.dart';
import 'package:bizda_bor/fuatures/search/domain/use_cases/search_usescase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsesCase searchUsesCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  SearchBloc({
    required this.searchUsesCase,
    required this.getAllCategoriesUseCase,
  }) : super(SearchState.initial()) {
    on<OnSearchEvent>(onSearchEvent);
    on<GetAllCetgoriesEvent>(
          (event, emit) async {
        emit(state.asLoading());
        final allCategories = await getAllCategoriesUseCase(Params());
        allCategories.fold(
              (l) {
            if (l is DioExceptions) {
              emit(state.asCategoryFailure(l));
            } else {
              emit(state.asCategoryFailure(l));
            }
          },
              (r) => emit(state.asCategorySuccess(r)),
        );
      },
    );
  }

  void onSearchEvent(OnSearchEvent event, Emitter<SearchState> emit) async {
    emit(state.asLoading());
    if(event.searchText?.isNotEmpty??false){
      state.products?.clear();
    }
    try {
      final failureOrSearch = await searchUsesCase(
          SearchParams(search: event.searchText, page: state.page, limit: 25));
      failureOrSearch.fold(
        (error) => emit(state.asSearchFailure(error)),
        (data) async {
          if (data is DioExceptions) {
            emit(state.asSearchFailure(data.failure));
          } else if (data is List<ProductModel>) {
            emit(state.asSearchSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asSearchFailure(e));
    }
  }
}
