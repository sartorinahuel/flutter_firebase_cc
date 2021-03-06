import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/globals.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';

class FirebaseUserRepo extends UserRepository {
  AppUser _currentUser = AppUser();

  AppUser get currentUser => this._currentUser;

  @override
  Future<void> deleteUser(String password) async {
    try {
      // Create a credential
      EmailAuthCredential credential = EmailAuthProvider.credential(
          email: _currentUser.email, password: password);

      // Reauthenticate
      await FirebaseAuth.instance.currentUser
          .reauthenticateWithCredential(credential);
      //delete user data
      await datastoreRepo.deleteDocument('users', _currentUser.uid);

      //delete user account
      await authService.deleteUser(_currentUser.uid);

      //Clean user bloc data
      _currentUser = AppUser();
      // this.userStreamController.add(_currentUser);
      
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      throw AppError(code: 'Delete User Data Error', message: e.toString());
    }
  }

  @override
  Future<void> getUser(String uid) async {
    if (FirebaseAuth.instance.currentUser.isAnonymous) {
      _currentUser = AppUser(
        name: 'John Doe',
        uid: uid,
      );
      this.userStreamController.add(_currentUser);
    } else {
      try {
        DocumentSnapshot document =
            await datastoreRepo.getDocument('users', uid);
        final userData = document.data();
        _currentUser = AppUser().fromJson(userData, uid);
        this.userStreamController.add(_currentUser);
      } on AppError catch (appError) {
        throw appError;
      } on NoSuchMethodError catch (e) {
        print(e);
        throw AppError(
          code: 'Can not read user data',
          message: 'No Such Method Error',
        );
      } catch (e) {
        throw AppError(code: 'Get User Data Error', message: e.toString());
      }
    }
  }

  @override
  Future<void> setUser(AppUser user) async {
    if (FirebaseAuth.instance.currentUser.isAnonymous) {
      _currentUser = user;
      this.userStreamController.add(_currentUser);
    } else {
      try {
        _currentUser = user;
        Map<String, dynamic> rawUserData = AppUser().toJson(user);
        await datastoreRepo.setDocument('users', user.uid, rawUserData);
        this.userStreamController.add(_currentUser);
      } on AppError catch (appError) {
        throw appError;
      } catch (e) {
        throw AppError(code: 'Set User Data Error', message: e.toString());
      }
    }
  }

  @override
  Future<void> logoutUser() async {
    _currentUser = AppUser();
  }

  @override
  Future<void> updateBirthday(DateTime newBirthday) async {
    _currentUser.birthday = newBirthday;
    await setUser(_currentUser);
    this.userStreamController.add(_currentUser);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    _currentUser.email = newEmail;
    await setUser(_currentUser);
    this.userStreamController.add(_currentUser);
  }

  @override
  Future<void> updateName(String newName) async {
    _currentUser.name = newName;
    await setUser(_currentUser);
    this.userStreamController.add(_currentUser);
  }

  @override
  Future<void> updatePhone(String newPhone) async {
    _currentUser.phone = newPhone;
    await setUser(_currentUser);
    this.userStreamController.add(_currentUser);
  }

  @override
  Future<void> updateProfilePicUrl(String newProfilePicUrl) async {
    _currentUser.profilePicUrl = newProfilePicUrl;
    await setUser(_currentUser);
    this.userStreamController.add(_currentUser);
  }

  @override
  Future<void> updateUserName(String newUserName) async {
    _currentUser.userName = newUserName;
    await setUser(_currentUser);
    this.userStreamController.add(_currentUser);
  }

  @override
  void dispose() {
    userStreamController?.close();
    super.dispose();
  }
}
