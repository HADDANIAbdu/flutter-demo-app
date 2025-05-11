import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService{
  final storage = FlutterSecureStorage();

  Future<void> saveToken(String key, String value) async{
    await storage.write(key: key, value: value);
  }

  Future<String?> readToken(String key) async{
    String? jwtToken = await storage.read(key: key);
    return jwtToken;
  }

  Future<void> removeToken(String key) async{
    await storage.delete(key: key);
  }
}