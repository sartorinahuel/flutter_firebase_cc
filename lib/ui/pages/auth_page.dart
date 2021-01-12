import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/auth/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _registerWithUserAndPass() {
      String user = 'sartorinahuel@gmail.com';
      String pass = '12341234';

      BlocProvider.of<AuthBloc>(context).add(AuthRegisterEvent(
        method: 'UserAndPassword',
        user: user,
        pass: pass,
      ));
    }

    void _loginWithUserAndPass() {
      String user = 'sartorinahuel@gmail.com';
      String pass = '12341234';

      BlocProvider.of<AuthBloc>(context).add(AuthLogInEvent(user, pass));
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logged Out'),
          SizedBox(
            height: 50,
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () => _registerWithUserAndPass(),
            child: Text('Register'),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () => _loginWithUserAndPass(),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
