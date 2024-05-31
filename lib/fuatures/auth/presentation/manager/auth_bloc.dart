// ignore_for_file: depend_on_referenced_packages

import 'package:bizda_bor/core/error/exception.dart';
import 'package:bizda_bor/fuatures/auth/data/models/user_model.dart';
import 'package:bizda_bor/fuatures/auth/domain/use_cases/confirmSms_usescase.dart';
import 'package:bizda_bor/fuatures/auth/domain/use_cases/register_usescase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../domain/use_cases/login_usescase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsesCase loginUsesCase;
  final ConfirmSmsUsesCase confirmSmsUsesCase;
  final RegisterUsesCase registerUsesCase;

  AuthBloc({
    required this.loginUsesCase,
    required this.registerUsesCase,
    required this.confirmSmsUsesCase,
  }) : super(const AuthState.initial()) {
    on<GetLoginEvent>(getLoginEvent);
    on<ConfirmSmsEvent>(confirmSmsEvent);
    on<RegisterEvent>(registerEvent);
  }

  void registerEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.asLoading());
    try {
      final failureOrSignUp = await registerUsesCase(RegisterParams(
        id: event.id,
        fullName: event.fullName,
        language: event.language,
        adress: event.adress,
      ));
      failureOrSignUp.fold(
        (error) => emit(state.asRegisterFailure(error)),
        (data) async {
          if (data is DioExceptions) {
            emit(state.asRegisterFailure(data.failure));
          } else if (data is UserData) {
            emit(state.asRegisterSuccess(data));
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asRegisterFailure(e));
    }
  }

  void getLoginEvent(GetLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.asLoading());
    try {
      final failureOrSignUp =
          await loginUsesCase(LoginParams(phone: event.phone));
      failureOrSignUp.fold(
        (error) => emit(state.asLoginFailure(error)),
        (data) async {
          emit(state.asLoginSuccess(data));
        },
      );
    } on Failure catch (e) {
      emit(state.asLoginFailure(e));
    }
  }

  void confirmSmsEvent(ConfirmSmsEvent event, Emitter<AuthState> emit) async {
    emit(state.asLoading());
    try {
      final failureOrSignUp = await confirmSmsUsesCase(
          ConfirmSmsParams(phone: event.phone, code: event.code));
      failureOrSignUp.fold(
        (error) => emit(state.asConfirmSmsFailure(error)),
        (data) async {
          if (data is int) {
            emit(state.asIsFirstOpenSuccess(data));
          } else if (data is UserData) {
            emit(state.asConfirmSmsSuccess(data));
          } else {
            if (data is DioExceptions) {
              emit(state.asConfirmSmsFailure(data.failure));
            }
          }
        },
      );
    } on Failure catch (e) {
      emit(state.asConfirmSmsFailure(e));
    }
  }
}
