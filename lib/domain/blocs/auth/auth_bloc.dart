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
    //UserBloc to get data
    _userBloc = BlocProvider.of<UserBloc>(context);

    //Listener that look if there is a session
    authService.authState().listen((uid) {
      print(uid);
      if (uid == 'Loading') {
        this.add(AuthLoadingEvent());
      }
      if (uid != '') {
        this.add(AuthIsLoggedInEvent(uid));
      }
      if (uid == '') {
        this.add(AuthUnauthEvent());
      }
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (state is AuthUnauthEvent) {
      yield AuthInitial();
    }

    if (state is AuthLoadingEvent) {
      yield AuthLoadingState();
    }

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

    //Anonymus login
    if (event is AuthAnonymusLoginEvent) {
      yield AuthLoadingState();
      try {
        String uid = await authService.anonymusSignIn();
        print('Sign in with anonymus user with id: $uid');
        _userBloc.add(UserAnonymusLoggedInEvent(uid));
        yield AuthLoggedInState();
      } on AppError catch (e) {
        yield AuthErrorState(e);
      }
    }

    if (event is AuthLogOutEvent) {
      yield AuthLoadingState();
      print('Loggin out...');
      await authService.doLogout();
      _userBloc.add(UserLogoutEvent());
      yield AuthLoggedOutState();
    }

    if (event is AuthLoginWithFacebookEvent) {
      yield AuthLoadingState();
      try {
        // String uid = await authService.doLoginWithFacebook();
        // _userBloc.add(UserGetDataEvent(uid));
        yield AuthLoggedInState();
      } on AppError catch (e) {
        yield AuthErrorState(e);
      }
    }

    if (event is AuthRegisterEvent) {
      yield AuthLoadingState();
      try {
        switch (event.method) {
          case 'UserAndPassword':
            final String uid = await authService.doRegisterWithUserAndPassword(
                event.user, event.pass);
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
