import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/repositories/datastore_repository.dart';

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
    } on FirebaseException catch (e) {
      //TODO catch with appError function
      throw AppError(code: e.code, message: e.message);
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<void> setDocument(String route, String id, Map data) async {
    try {
      final DocumentSnapshot requestedDoc =
          await firestore.collection(route).doc(id).get();

      //Verifies if the document exists to decide to update or set
      if (requestedDoc.exists) {
        await firestore.collection(route).doc(id).update(data).timeout(
          Duration(seconds: 5),
          onTimeout: () {
            print('Set User Data Error Timeout');
            throw AppError.connectionTimeout();
          },
        );
      } else {
        await firestore.collection(route).doc(id).set(data).timeout(
          Duration(seconds: 5),
          onTimeout: () {
            print('Set User Data Error Timeout');
            throw AppError.connectionTimeout();
          },
        );
      }
    } on AppError catch (appError) {
      throw appError;
    } on FirebaseException catch (e) {
      //TODO catch with appError function
      throw AppError(code: e.code, message: e.message);
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
    } on FirebaseException catch (e) {
      //TODO catch with appError function
      throw AppError(code: e.code, message: e.message);
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Stream streamDocument(String route, String id) async* {
    yield firestore.collection(route).doc(id).snapshots().handleError(
          (error) => throw AppError(
            code: 'Stream error',
            message: error.toString(),
          ),
        );
  }

  @override
  Stream streamCollection(String route) async* {
    yield firestore.collection(route).snapshots().handleError(
          (error) => throw AppError(
            code: 'Stream error',
            message: error.toString(),
          ),
        );
  }

  @override
  Future getCollection(String route) async {
    try {
      return await firestore.collection(route).get().timeout(
        Duration(seconds: 5),
        onTimeout: () {
          print('Get User Data Error Timeout');
          throw AppError.connectionTimeout();
        },
      );
    } on FirebaseException catch (e) {
      throw AppError(code: e.code, message: e.message);
    } on AppError catch (appError) {
      throw appError;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<void> setCollection(String route) {
    // TODO: implement setCollection
    throw UnimplementedError();
  }
}
