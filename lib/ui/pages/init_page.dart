import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_cc/domain/blocs/auth/auth_bloc.dart';
import 'error_page.dart';
import 'home_page.dart';
import 'auth_page.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onError() {
      BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthErrorState) {
          return AuthErrorPage(
            appError: state.appError,
            onError: _onError,
          );
        }

        if (state is AuthLoadingState) {
          return Scaffold(
            body: Center(
              child: Text('Cargando...'),
            ),
          );
        }

        if (state is AuthLoggedInState) {
          return HomePage();
        }

        return AuthPage();
      },
    );
  }
}
