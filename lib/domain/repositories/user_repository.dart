import 'dart:async';

import '../../domain/entities/user.dart';

abstract class UserRepository {
  AppUser _currentUser;

  AppUser get currentUser => this._currentUser;

  StreamController<AppUser> userStreamController =
      new StreamController<AppUser>.broadcast();

  Stream<AppUser> get userStream => userStreamController.stream;

  Future<void> getUser(String uid);

  Future<void> setUser(AppUser user);

  Future<void> updateUserName(String newUserName);

  Future<void> updatePhone(String newPhone);

  Future<void> updateBirthday(DateTime newBirthday);

  Future<void> updateEmail(String newEmail);

  Future<void> updateName(String newName);

  Future<void> updateProfilePicUrl(String newProfilePicUrl);

  Future<void> deleteUser(String password);

  Future<void> logoutUser();

  void dispose() {
    userStreamController?.close();
  }
}
