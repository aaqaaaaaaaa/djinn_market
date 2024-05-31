part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class GetLoginEvent extends AuthEvent {
  final String? phone;

  GetLoginEvent({this.phone});
}

class ConfirmSmsEvent extends AuthEvent {
  final String? phone, code;

  ConfirmSmsEvent({this.phone, this.code});
}

class RegisterEvent extends AuthEvent {
  final String? fullName, adress, language;
  final int? id;

  RegisterEvent({
    this.fullName,
    this.adress,
    this.language,
    this.id,
  });
}
