import 'dart:convert';
import 'dart:io';

import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_firebase_cc/domain/entities/user.dart';
import 'package:flutter_firebase_cc/domain/repositories/user_repository.dart';

class HttpUserRepo extends UserRepository {
  static const route = '/users';
  final String endpoint;

  HttpUserRepo(this.endpoint);

  AppUser _currentUser = AppUser();

  AppUser get currentUser => this._currentUser;

  @override
  Future<void> getUser(String uid) async {
    final http.Response response = await http.get(endpoint + route + '/$uid');
    final Map<String, dynamic> rawUserData = jsonDecode(response.body);
    _currentUser = AppUser().fromJson(rawUserData, uid);
    this.userStreamController.add(_currentUser);
  }

  @override
  Future<void> setUser(AppUser user) async {
    try {
      _currentUser = user;
      Map<String, String> rawUserData = AppUser().toJson(user);
      final http.Response response =
          await http.put(endpoint + route + '/${user.uid}', body: rawUserData);
      this.userStreamController.add(_currentUser);
    } on HttpException catch (e) {
      throw AppError(code: e.uri.toString(), message: e.message);
    } catch (e){
      print(e);
      throw AppError(code: 'Error during setting user to database', message: e.toString());
    }
  }

  @override
  Future<void> deleteUser(String password) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateBirthday(DateTime newBirthday) {
    // TODO: implement updateBirthday
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmail(String newEmail) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<void> updateName(String newName) {
    // TODO: implement updateName
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhone(String newPhone) {
    // TODO: implement updatePhone
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfilePicUrl(String newProfilePicUrl) {
    // TODO: implement updateProfilePicUrl
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserName(String newUserName) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }
}
