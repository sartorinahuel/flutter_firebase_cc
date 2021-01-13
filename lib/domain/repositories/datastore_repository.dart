abstract class DatastoreRepository {
  Future<dynamic> getDocument(String route, String id);
  Future<void> setDocument(String route, String id, Map data);
  Future<void> deleteDocument(String route, String id);
  Stream<dynamic> streamDocument(String route, String id);
  Stream<dynamic> streamCollection(String route);
}
