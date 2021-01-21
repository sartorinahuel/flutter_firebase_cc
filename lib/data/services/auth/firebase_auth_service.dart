import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';
import '../../../domain/services/auth_service.dart';

class FirebaseAuthService extends AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> anonymusSignIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      throw AppError(
        code: e.code,
        message: e.message,
      );
    }
  }

  //returns uid if there is session
  StreamController<String> uidStream = StreamController.broadcast();

  @override
  Stream<String> authState() async* {
    uidStream.add('Loading');
    firebaseAuth.authStateChanges().listen((User user) {
      if (user == null) {
        print('The is no user logged in!');
        uidStream.add('');
      } else {
        print('The user ${user.uid} is logged in!');
        uidStream.add(user.uid);
      }
    });
    yield* uidStream.stream;
  }

  @override
  Future<void> changePassword(String newPassword, String oldPassword) async {
    User user = firebaseAuth.currentUser;
    try {
      // Create a credential
      EmailAuthCredential credential = EmailAuthProvider.credential(
          email: userRepo.currentUser.email, password: oldPassword);

      // Reauthenticate
      await FirebaseAuth.instance.currentUser
          .reauthenticateWithCredential(credential);

      //Change password
      await user.updatePassword(newPassword);
      
      print('Password updated!');
    } catch (e) {
      throw AppError.genericError(
          message: 'An error occur during changing password');
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        //TODO Handle this error
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
      throw AppError(
        code: e.code,
        message: e.message,
      );
    }
  }

  @override
  Future<String> doLoginWithApple() {
    // TODO: implement doLoginWithApple
    throw UnimplementedError();
  }

  @override
  Future<String> doLoginWithFacebook() async {
    //TODO continue with implementation
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    return userCredential.user.uid;
  }

  @override
  Future<String> doLoginWithGoogle() {
    // TODO: implement doLoginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<String> doLoginWithPhone() {
    // TODO: implement doLoginWithPhone
    throw UnimplementedError();
  }

  @override
  Future<String> doLoginWithTwitter() {
    // TODO: implement doLoginWithTwitter
    throw UnimplementedError();
  }

  @override
  Future<String> doLoginWithUserAndPassword(
      String user, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user,
        password: password,
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      throw authErrorHandler(e);
    } catch (e) {
      //Generic error
      throw AppError.genericError(
        message: 'Something went wrong during login',
      );
    }
  }

  @override
  Future<void> doLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<String> doRegisterWithUserAndPassword(
      String user, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user,
        password: password,
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      throw authErrorHandler(e);
    } catch (e) {
      print(e);
      throw AppError.genericError(
          message: 'Something went wrong during register');
    }
  }

  @override
  Future<void> isPersistantSession(bool persistant) async {
    // Disable persistence on web platforms
    if (persistant) {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    } else {
      await FirebaseAuth.instance.setPersistence(Persistence.NONE);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    User user = firebaseAuth.currentUser;
    await user.sendEmailVerification().whenComplete(() {
      //TODO Show "Email Sent" on screen
      print('Verification email sent!');
    }).catchError(
      throw AppError.genericError(message: 'Error sending email verification'),
    );
  }

  @override
  AppError authErrorHandler(e) {
    //no connectivity error
    if (e.message.contains('Unable to resolve host')) {
      throw AppError.noConnection();
    }

    switch (e.code) {
      case 'user-not-found':
        print('No user found for that email.');
        throw AppError.noUserFound();
        break;
      case 'wrong-password':
        print('Wrong password provided for that user.');
        throw AppError.wrongPassword();
        break;
      case 'weak-password':
        print('The password provided is too weak.');
        throw AppError.weekPassword();
        break;
      case 'email-already-in-use':
        print('The account already exists for that email.');
        throw AppError.emailInUse();
        break;
      case 'user-disabled':
        print('The user account is disabled.');
        throw AppError.userDisabled();
        break;
      case 'account-exists-with-different-credential':
        print('The account exists with different credential.');
        //TODO handle this error
        throw AppError(
            code: 'The account exists with different credential',
            message: 'Try a different login method.');
        break;
      default:
        //other errors
        print(e.code);
        throw AppError(code: e.code, message: e.message);
    }
  }
}
