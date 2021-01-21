import '../data/repositories/user_repository/firebase_user_repository.dart';
import '../data/services/auth/firebase_auth_service.dart';
import '../data/services/datastore/firebase_cloudstore.dart';
import '../domain/repositories/datastore_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/services/auth_service.dart';

//Global variables
const String endpoint =  'https://flutter-firebase-cc-default-rtdb.firebaseio.com';

//Dependencies
final UserRepository userRepo = FirebaseUserRepo();
final AuthService authService = FirebaseAuthService();
final DatastoreRepository datastoreRepo = FirebaseCloudstoreRepository();
