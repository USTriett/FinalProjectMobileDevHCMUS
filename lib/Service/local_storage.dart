import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal() {
    // initialization logic
  }

  final storage = const FlutterSecureStorage();

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(key: "id", value: userCredential.user!.uid.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getUserId() async {
    return await storage.read(key: "id");
  }

  Future<void> deleteTokenAndData() async {
    await storage.delete(key: "token");
    await storage.delete(key: "id");
  }

  Future<void> clearStorage() async {
    await storage.deleteAll();
  }
}
