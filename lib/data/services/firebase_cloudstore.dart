import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_firebase_cc/domain/entities/app_error.dart';
import 'package:flutter_firebase_cc/domain/repositories/datastore_repository.dart';

class FirebaseCloudstoreRepository extends DatastoreRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future getDocument(String route, String id) async {
    try {
      //try connection setting last access
      await firestore
          .collection(route)
          .doc(id)
          .update({'lastConnection': DateTime.now().toIso8601String()}).timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('Get User Data Error Timeout');
          throw AppError.connectionTimeout();
        },
      );
      //if no error setting data, return document
      return await firestore.collection(route).doc(id).get();
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<void> setDocument(String route, String id, Map data) async {
    //TODO update document if exists.
    try {
      await firestore.collection(route).doc(id).set(data).timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('Set User Data Error Timeout');
          throw AppError.connectionTimeout();
        },
      );
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<void> deleteDocument(String route, String id) async {
    try {
      await firestore.collection(route).doc(id).delete().timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('Get User Data Error Timeout');
          throw AppError.connectionTimeout();
        },
      );
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
