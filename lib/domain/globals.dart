import 'package:flutter_firebase_cc/data/repositories/user_repository/firebase_user_repository.dart';
import 'package:flutter_firebase_cc/data/repositories/user_repository/http_user_repository.dart';
import 'package:flutter_firebase_cc/data/services/auth/firebase_auth_service.dart';
import 'package:flutter_firebase_cc/data/services/datastore/firebase_cloudstore.dart';
import 'package:flutter_firebase_cc/domain/repositories/datastore_repository.dart';
import 'package:flutter_firebase_cc/domain/repositories/user_repository.dart';
import 'package:flutter_firebase_cc/domain/services/auth_service.dart';

//Global variables
const String endpoint =  'https://flutter-firebase-cc-default-rtdb.firebaseio.com';

//Dependencies
final UserRepository userRepo = FirebaseUserRepo();
final AuthService authService = FirebaseAuthService();
final DatastoreRepository datastoreRepo = FirebaseCloudstoreRepository();

//User current credentials
String password = 'password';
