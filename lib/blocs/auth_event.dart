part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}
class LoginEvents extends AuthEvent{
  final String email;
  final String password;

  LoginEvents({required this.email,required this.password});
}
class RegisterEvents extends AuthEvent{}