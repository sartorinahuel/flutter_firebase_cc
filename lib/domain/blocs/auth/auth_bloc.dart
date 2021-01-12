import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/user/user_bloc.dart';
import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:meta/meta.dart';

import '../../globals.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserBloc _userBloc;

  AuthBloc(BuildContext context) : super(AuthInitial()) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    authService.authState().listen((uid) {
      if (uid != '') {
        this.add(AuthIsLoggedInEvent(uid));
      }
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLogInEvent) {
      yield AuthLoadingState();
      try {
        String uid = await authService.doLoginWithUserAndPassword(
            event.user, event.pass);
        _userBloc.add(UserGetDataEvent(uid));
        yield AuthLoggedInState();
      } on AppError catch (e) {
        yield AuthErrorState(e);
      }
    }

    //It comes from the persistant login or social login
    if (event is AuthIsLoggedInEvent) {
      yield AuthLoadingState();
      _userBloc.add(UserGetDataEvent(event.uid));
      yield AuthLoggedInState();
    }

    if (event is AuthLogOutEvent) {
      yield AuthLoadingState();
      print('Loggin out...');
      await authService.doLogout();
      _userBloc.add(UserLogoutEvent());
      yield AuthLoggedOutState();
    }

    if (event is AuthRegisterEvent) {
      yield AuthLoadingState();
      try {
        switch (event.method) {
          case 'UserAndPassword':
            final String uid = await authService.doRegisterWithUserAndPassword(
                event.user, event.pass);
            //TODO get left user data
            _userBloc.add(
              UserRegisterEvent(
                uid: uid,
                email: event.user,
                userName: 'sartorinahuel',
                name: 'Nahuel Sartori',
              ),
            );
            break;
        }
        yield AuthLoggedInState();
      } on AppError catch (e) {
        yield AuthErrorState(e);
      }
    }
  }
}
