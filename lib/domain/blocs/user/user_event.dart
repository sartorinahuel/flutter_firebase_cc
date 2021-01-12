part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserGetDataEvent extends UserEvent {
  final String uid;

  UserGetDataEvent(this.uid);
}

class UserRegisterEvent extends UserEvent {
  final String uid;
  final String email;
  final String userName;
  final String name;

  UserRegisterEvent({
    this.userName,
    this.name,
    this.email,
    this.uid,
  });
}

class UserUpdatePhoneEvent extends UserEvent {
  final String newPhone;

  UserUpdatePhoneEvent(this.newPhone);
}

class UserUpdateBirthdayEvent extends UserEvent {
  final DateTime newBirthday;

  UserUpdateBirthdayEvent(this.newBirthday);
}

class UserDeleteUserEvent extends UserEvent {}

class UserLogoutEvent extends UserEvent {}
