import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:flutter_firebase_cc/domain/services/auth_service.dart';

class MockAuthService extends AuthService {
  @override
  Future<String> anonymusSignIn() {
    // TODO: implement anonymusSignIn
    throw UnimplementedError();
  }

  @override
  Stream<String> authState() {
    // TODO: implement authState
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword(String password, String oldPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String uid) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<String> doLoginWithApple() {
    // TODO: implement doLoginWithApple
    throw UnimplementedError();
  }

  @override
  Future<String> doLoginWithFacebook() {
    // TODO: implement doLoginWithFacebook
    throw UnimplementedError();
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
    String uid = '6YVnQ0BbbLVNZvAwKLv8BA4HIPF3';
    await Future.delayed(Duration(seconds: 1));

    //Test invalid email error
    // throw AppError(
    //   code: 'invalid-email',
    //   message: 'the given email is not valid',
    // );
    return uid;
  }

  @override
  Future<void> doLogout() {
    // TODO: implement doLogout
    throw UnimplementedError();
  }

  @override
  Future<String> doRegisterWithUserAndPassword(String user, String password) {
    // TODO: implement doRegisterWithUserAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> isPersistantSession(bool persistant) {
    // TODO: implement isPersistantSession
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  AppError authErrorHandler(error) {
    // TODO: implement authErrorHandler
  }
}
