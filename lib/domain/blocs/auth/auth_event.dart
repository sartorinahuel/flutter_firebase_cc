part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogInEvent extends AuthEvent {
  final String user;
  final String pass;

  AuthLogInEvent(this.user, this.pass);
}

class AuthIsLoggedInEvent extends AuthEvent {
  final String uid;

  AuthIsLoggedInEvent(this.uid);
}

class AuthRegisterEvent extends AuthEvent {
  final String method;
  final String user;
  final String pass;

  AuthRegisterEvent({@required this.method, this.user, this.pass});
}

class AuthLogOutEvent extends AuthEvent {}

class AuthLoadingEvent extends AuthEvent {}

class AuthLoginWithFacebookEvent extends AuthEvent {}

class AuthLoginWithGoogleEvent extends AuthEvent {}

class AuthLoginWithAppleEvent extends AuthEvent {}

class AuthLoginWithTwitterEvent extends AuthEvent {}

class AuthLoginWithPhoneEvent extends AuthEvent {}

class AuthUnauthEvent extends AuthEvent {}

class AuthAnonymusLoginEvent extends AuthEvent {}
