part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserNeedReauthState extends UserState {}

class UserErrorState extends UserState {
  final AppError appError;

  UserErrorState(this.appError);
}

class UserDataState extends UserState {
  final AppUser appUser;

  UserDataState(this.appUser);
}
