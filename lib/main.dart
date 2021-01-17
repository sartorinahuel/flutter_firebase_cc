import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_cc/domain/blocs/auth/auth_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/user/user_bloc.dart';
import 'package:flutter_firebase_cc/ui/pages/init_page.dart';

import 'domain/entities/app_error.dart';
import 'ui/pages/error_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase CC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {

            //On Firebase Error
            if (snapshot.hasError) {
              return AuthErrorPage(
                appError: AppError(
                  code: 'Firebase Error',
                  message: 'We couldn´t initialize Firebase App',
                ),
                onError: (){},
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => UserBloc()),
                  BlocProvider(create: (context) => AuthBloc(context)),
                ],
                child: InitPage(),
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.green),
              ),
            );
          }),
    );
  }
}
