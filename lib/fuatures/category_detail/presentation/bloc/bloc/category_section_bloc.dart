import 'package:bizda_bor/fuatures/category_detail/data/model/category_childsection_model.dart';
import 'package:bizda_bor/fuatures/category_detail/data/model/category_section_model.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/usecase/get_all_child_sections_usecase.dart';
import 'package:bizda_bor/fuatures/category_detail/domain/usecase/get_all_sections_usecase.dart';
import 'package:bizda_bor/services/get_products/data/models/product_model.dart';
import 'package:bizda_bor/services/get_products/domain/use_cases/get_product_usescase.dart';
import 'package:bloc/bloc.dart';

import '../../../../../core/error/failure.dart';

part 'category_section_event.dart';
part 'category_section_state.dart';

class CategorySectionBloc
    extends Bloc<CategorySectionEvent, CategorySectionState> {
  GetAllSectionsUsecase getAllSectionsUsecase;
  GetAllChildSectionsUsecase childSectionsUsecase;
  GetProductUsesCase getProductUsesCase;

  CategorySectionBloc({
    required this.getAllSectionsUsecase,
    required this.getProductUsesCase,
    required this.childSectionsUsecase,
  }) : super(CategorySectionState.initial()) {
    on<GetChildSectionEvent>(getChildSectionEvent);
    on<GetProductsChildSectionEvent>(getProductsChildSectionEvent);
    on<GetCategorySectionList>(
      (event, emit) async {
        emit(state.asLoading());
        final result = await getAllSectionsUsecase(
            SectionParams(categoryId: event.categoryId));
        result.fold(
          (l) => emit(state.asSectionFailure(l)),
          (r) => emit(
            state.asSectionSuccess(r),
          ),
        );
      },
    );
  }

  getChildSectionEvent(
      GetChildSectionEvent event, Emitter<CategorySectionState> emit) async {
    emit(state.asChildSectionLoading());
    try {
      final result = await childSectionsUsecase(
          ChildSectionParams(sectionId: event.sectionId, page: 1));
      result.fold(
        (l) => emit(state.asChildSectionFailure(l)),
        (data) async {
          emit(state.asChildSectionSuccess(data));
        },
      );
    } on Failure catch (e) {
      emit(state.asChildSectionFailure(e));
    }
  }

  getProductsChildSectionEvent(GetProductsChildSectionEvent event,
      Emitter<CategorySectionState> emit) async {
    emit(state.asProductsLoading());
    try {
      final result = await getProductUsesCase(GetProductParams(
          childSection: event.childSectionId, page: 1, limit: 30));
      result.fold(
        (l) => emit(state.asProductsFailure(l)),
        (data) async {
          emit(state.asProductsSuccess(data ?? []));
        },
      );
    } on Failure catch (e) {
      emit(state.asProductsFailure(e));
    }
  }
}
