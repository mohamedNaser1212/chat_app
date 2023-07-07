part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {}
class LoginLoading extends AuthState {}
class LoginFailure extends AuthState {
  String errorMessage;
  LoginFailure({required this.errorMessage});
}

class RegesterSuccess extends AuthState {}
class RegesterLoading extends AuthState {}
class RegesterFailure extends AuthState {
  String errorMessage;
  RegesterFailure({required this.errorMessage});
}

