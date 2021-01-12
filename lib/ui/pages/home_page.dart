import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_cc/domain/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/user/user_bloc.dart';
import 'package:flutter_firebase_cc/domain/entities/user.dart';

import 'error_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onError() {
      BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
    }

    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserDataState) {
        final AppUser currentUser = state.appUser;

        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Firebase CC'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You email is: ${currentUser.email}',
                ),
                Text(
                  'You email is: ${currentUser.name}',
                ),
                Text(
                  'You email is: ${currentUser.userName}',
                ),
                Text(
                  'You email is: ${currentUser.birthday}',
                ),
                Text(
                  'You email is: ${currentUser.phone}',
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(UserUpdatePhoneEvent('+5491154814023'));
                  },
                  child: Text('Change phone'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(UserUpdateBirthdayEvent(DateTime(1990, 11, 11)));
                  },
                  child: Text('Change Birthday'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(UserGetDataEvent(currentUser.uid));
                  },
                  child: Text('Refresh User Data'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
                  },
                  child: Text('Logout'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
                  },
                  child: Text(
                    'Delete User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      if (state is UserErrorState) {
        return AuthErrorPage(
          appError: state.appError,
          onError: _onError,
        );
      }

      return Scaffold(
        body: Center(
          child: Text('Cargando usuario...'),
        ),
      );
    });
  }
}
