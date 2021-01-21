import 'package:flutter_firebase_cc/domain/entities/app_error.dart';

abstract class AuthService {
  Future<String> doLoginWithUserAndPassword(String user, String password);

  Future<String> doRegisterWithUserAndPassword(String user, String password);

  //Delete user from backend
  Future<void> deleteUser(String uid);

  //Email verification from current user
  Future<void> sendEmailVerification();

  Future<void> changePassword(String newPassword, String oldPassword);

  Future<void> isPersistantSession(bool persistant);

  Future<String> anonymusSignIn();

  Future<String> doLoginWithGoogle();

  Future<String> doLoginWithFacebook();

  Future<String> doLoginWithApple();

  Future<String> doLoginWithTwitter();

  Future<String> doLoginWithPhone();

  Future<void> doLogout();

  //Must return uid or empty
  Stream<String> authState();

  AppError authErrorHandler(error);
}
