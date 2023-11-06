import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const storage = FlutterSecureStorage();

  static write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static read(String key) async {
    return await storage.read(key: key);
  }
}
