part of 'auth_bloc.dart';

enum AuthStateStatus {
  initial,
  loading,
  loginSuccess,
  loginFailure,
  registerSuccess,
  registerFailure,
  confirmSmsSuccess,
  isFirstOpenSuccess,
  confirmSmsFailure,
}

class AuthState {
  final AuthStateStatus status;
  final UserData? userModel;
  final Failure? error;
  final String? message;
  final String? code;
  final int? userId;

  const AuthState._({
    this.status = AuthStateStatus.initial,
    this.error,
    this.userId,
    this.userModel,
    this.code,
    this.message,
  });

  const AuthState.initial() : this._();

  AuthState asLoading() {
    return copyWith(
      status: AuthStateStatus.loading,
    );
  }

  AuthState asLoginSuccess(String? code) {
    return copyWith(status: AuthStateStatus.loginSuccess, code: code);
  }

  AuthState asLoginFailure(Failure failure) {
    return copyWith(status: AuthStateStatus.loginFailure, error: failure);
  }

  AuthState asIsFirstOpenSuccess(int userId) {
    return copyWith(status: AuthStateStatus.isFirstOpenSuccess, userId: userId);
  }

  AuthState asConfirmSmsSuccess(UserData? userModel) {
    return copyWith(
        status: AuthStateStatus.confirmSmsSuccess, userModel: userModel);
  }

  AuthState asConfirmSmsFailure(Failure failure) {
    return copyWith(status: AuthStateStatus.confirmSmsFailure, error: failure);
  }

  AuthState asRegisterSuccess(UserData? userModel) {
    return copyWith(
        status: AuthStateStatus.registerSuccess, userModel: userModel);
  }

  AuthState asRegisterFailure(Failure failure) {
    return copyWith(status: AuthStateStatus.registerFailure, error: failure);
  }

  AuthState copyWith({
    AuthStateStatus? status,
    Failure? error,
    UserData? userModel,
    String? message,
    String? code,
    int? userId,
  }) {
    return AuthState._(
      status: status ?? this.status,
      error: error ?? this.error,
      code: code ?? this.code,
      userModel: userModel ?? this.userModel,
      message: message,
      userId: userId,
    );
  }
}
