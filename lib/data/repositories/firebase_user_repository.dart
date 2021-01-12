import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class FirebaseUserRepo extends UserRepository {
  AppUser _currentUser = AppUser();

  AppUser get currentUser => this._currentUser;

  @override
  Future<void> deleteUser() async {
    try {
      await datastoreRepo.deleteDocument('users', _currentUser.uid);
      await authService.deleteUser(_currentUser.uid);
      _currentUser = AppUser();
      this.userStreamController.add(_currentUser);
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      throw AppError(code: 'Delete User Data Error', message: e.toString());
    }
  }

  @override
  Future<void> getUser(String uid) async {
    try {
      DocumentSnapshot document = await datastoreRepo.getDocument('users', uid);
      final userData = document.data();
      _currentUser = fromJson(userData, uid);
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

  @override
  Future<void> setUser(AppUser user) async {
    try {
      _currentUser = user;
      Map<String, dynamic> rawUserData = toJson(user);
      await datastoreRepo.setDocument('users', user.uid, rawUserData);
      this.userStreamController.add(_currentUser);
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      throw AppError(code: 'Set User Data Error', message: e.toString());
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
  AppUser fromJson(Map data, String uid) {
    AppUser newUser = AppUser();
    newUser.uid = uid;
    newUser.userName = data['userName'] ?? '';
    newUser.name = data['name'] ?? '';
    newUser.email = data['email'];
    newUser.birthday = data['birthday'] != null
        ? DateTime.parse(data['birthday'])
        : DateTime(1900, 1, 1);
    newUser.phone = data['phone'] ?? '';
    newUser.profilePicUrl = data['profilePicUrl'] ?? '';

    return newUser;
  }

  @override
  Map<String, dynamic> toJson(AppUser user) {
    return {
      'userName': user.userName,
      'name': user.name,
      'email': user.email,
      'birthday':
          user.birthday == null ? null : user.birthday.toIso8601String(),
      'phone': user.phone,
      'profilePicUrl': user.profilePicUrl,
    };
  }

  @override
  void dispose() {
    userStreamController?.close();
    super.dispose();
  }
}
