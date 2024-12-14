import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String SESSION_KEY = "sessionToken";

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> saveData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }

  Future<String?> getSessionToken() async {
    return await storage.read(key: SESSION_KEY);
  }

  Future<void> saveSessionToken(String value) async {
    await storage.write(key: SESSION_KEY, value: value);
  }
}
