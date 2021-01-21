import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';

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
      if(password != 'password'){
        pass = password;
      }

      BlocProvider.of<AuthBloc>(context).add(AuthLogInEvent(user, pass));
    }

    return Scaffold(
      body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: double.infinity,
              ),
              Text('Logged Out'),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              RaisedButton(
                onPressed: () => _registerWithUserAndPass(),
                child: Text('Register'),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              RaisedButton(
                onPressed: () => _loginWithUserAndPass(),
                child: Text('Login'),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              RaisedButton(
                color: Colors.blue[800],
                onPressed: () {
                  print('Missing implementation');
                  // BlocProvider.of<AuthBloc>(context).add(AuthLoginWithFacebookEvent());
                },
                child: Text('Login with Facebook', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              RaisedButton(
                onPressed: () => BlocProvider.of<AuthBloc>(context).add(AuthAnonymusLoginEvent()),
                child: Text('Anonymus Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
