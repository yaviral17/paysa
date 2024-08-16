import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageAPI {
  static const storage = FlutterSecureStorage();

  static Future<void> writeMap(String key, Map<String, dynamic> value) async {
    await storage.write(key: key, value: jsonEncode(value));
  }

  static Future<Map<String, dynamic>?> readMap(String key) async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: key);
    if (value == null) {
      return null;
    }
    return Map<String, dynamic>.from(jsonDecode(value));
  }

  static Future<bool> contains(String key) async {
    return await storage.containsKey(key: key);
  }

  static Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  static Future<void> writeString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> readRead(String key) async {
    return await storage.read(key: key);
  }

  static Future<void> writeBool(String key, bool value) async {
    await storage.write(key: key, value: value.toString());
  }

  static Future<bool?> readBool(String key) async {
    String? value = await storage.read(key: key);
    if (value == null) {
      return null;
    }
    return value == 'true';
  }

  static Future<void> writeInt(String key, int value) async {
    await storage.write(key: key, value: value.toString());
  }

  static Future<int?> readInt(String key) async {
    String? value = await storage.read(key: key);
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }

  static Future<void> writeDouble(String key, double value) async {
    await storage.write(key: key, value: value.toString());
  }

  static Future<double?> readDouble(String key) async {
    String? value = await storage.read(key: key);
    if (value == null) {
      return null;
    }
    return double.parse(value);
  }

  static Future<void> writeList(String key, List<String> value) async {
    await storage.write(key: key, value: jsonEncode(value));
  }

  static Future<List<String>?> readList(String key) async {
    String? value = await storage.read(key: key);
    if (value == null) {
      return null;
    }
    return List<String>.from(jsonDecode(value));
  }
}
