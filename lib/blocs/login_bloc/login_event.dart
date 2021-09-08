part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginDoEvent extends LoginEvent {
  String username, password;
  LoginDoEvent({required this.username, required this.password});
}
