import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:flutter_firebase_cc/domain/entities/user.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(BuildContext context) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserGetDataEvent) {
      AppUser _currentUser = AppUser();
      yield UserLoadingState();
      try {
        await userRepo
            .getUser(event.uid)
            .then((_) => _currentUser = userRepo.currentUser);
        yield UserDataState(_currentUser);
      } on AppError catch (e) {
        yield UserErrorState(e);
      }
    }

    if (event is UserChangePasswordEvent) {
      yield UserLoadingState();
      try {
        await authService.changePassword(event.password, event.oldPassword);
        yield UserDataState(userRepo.currentUser);
      } on AppError catch (e) {
        yield UserErrorState(e);
      }
    }

    if (event is UserUpdatePhoneEvent) {
      yield UserLoadingState();
      try {
        await userRepo.updatePhone(event.newPhone);
        AppUser _currentUser = userRepo.currentUser;
        yield UserDataState(_currentUser);
      } on AppError catch (e) {
        yield UserErrorState(e);
      }
    }

    if (event is UserUpdateBirthdayEvent) {
      yield UserLoadingState();
      try {
        await userRepo.updateBirthday(event.newBirthday);
        AppUser _currentUser = userRepo.currentUser;
        yield UserDataState(_currentUser);
      } on AppError catch (e) {
        yield UserErrorState(e);
      }
    }

    if (event is UserDeleteUserEvent) {
      yield UserLoadingState();
      AppError appError = AppError(
        code: 'User Deleted Successfully',
        message: '',
      );
      try {
        await userRepo.deleteUser(event.password);
        yield UserErrorState(appError);
      } on AppError catch (appError) {
        yield UserErrorState(appError);
      }
    }

    if (event is UserLogoutEvent) {
      yield UserLoadingState();
      await userRepo.logoutUser();
      yield UserInitial();
    }

    if (event is UserAnonymusLoggedInEvent) {
      yield UserLoadingState();
      AppUser anonUser = AppUser(
        name: 'John Doe',
        uid: event.uid,
      );
      await userRepo.setUser(anonUser);
      yield UserDataState(anonUser);
    }

    if (event is UserRegisterEvent) {
      yield UserLoadingState();
      AppUser _currentUser = AppUser();
      _currentUser.uid = event.uid;
      _currentUser.email = event.email;
      _currentUser.name = event.name;
      _currentUser.userName = event.userName;
      await userRepo.setUser(_currentUser);
      yield UserDataState(_currentUser);
    }
  }
}
