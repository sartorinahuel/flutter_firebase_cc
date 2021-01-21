import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_cc/domain/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/user/user_bloc.dart';
import 'package:flutter_firebase_cc/domain/entities/user.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';
import 'package:flutter_firebase_cc/ui/pages/change_password_page.dart';

import 'confirm_delete_user_page.dart';
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25, width: double.infinity),
                Text(
                  'You email is: ${currentUser.email}',
                ),
                SizedBox(height: 10),
                Text(
                  'You name is: ${currentUser.name}',
                ),
                SizedBox(height: 10),
                Text(
                  'You userName is: ${currentUser.userName}',
                ),
                SizedBox(height: 10),
                Text(
                  'You birthday is: ${currentUser.birthday}',
                ),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(UserUpdateBirthdayEvent(DateTime(1990, 11, 11)));
                  },
                  child: Text('Change Birthday'),
                ),
                SizedBox(height: 10),
                Text(
                  'You phone is: ${currentUser.phone}',
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
                        .add(UserGetDataEvent(currentUser.uid));
                  },
                  child: Text('Refresh User Data'),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<UserBloc>(context),
                            child: ChangePasswordPage(),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('Change Password'),
                ),
                SizedBox(height: 50),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<UserBloc>(context),
                            child: BlocProvider.value(
                                value: BlocProvider.of<AuthBloc>(context),
                                child: ConfirmDeletePage()),
                          );
                        },
                      ),
                    );
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
