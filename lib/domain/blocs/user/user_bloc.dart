import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:flutter_firebase_cc/domain/entities/user.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

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
      AppError appError;

      await userRepo.deleteUser().catchError((error) => appError = error);

      if (appError != null) {
        yield UserErrorState(appError);
      } else {
        yield UserInitial();
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
        isAnonymus: true,
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
