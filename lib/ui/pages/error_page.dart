import 'package:flutter/material.dart';

import '../.././domain/entities/app_error.dart';

class AuthErrorPage extends StatelessWidget {
  final AppError appError;
  final Function onError;

  const AuthErrorPage({this.appError, this.onError});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appError.code),
            SizedBox(height: 20),
            Text(appError.message),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Volver'),
              onPressed: onError,
            )
          ],
        ),
      ),
    );
  }
}
