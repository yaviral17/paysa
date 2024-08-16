import 'package:flutter/services.dart';

class FlutterSecureStorageAPI {
  static const String _channelName = 'data.paysa.in/flutter_secure_storage';
  static const MethodChannel _channel = MethodChannel(_channelName);

  static Future<void> write(String key, String value) async {
    await _channel
        .invokeMethod('write', <String, dynamic>{'key': key, 'value': value});
  }

  static Future<String?> read(String key) async {
    return await _channel.invokeMethod('read', <String, dynamic>{'key': key});
  }

  static Future<void> delete(String key) async {
    await _channel.invokeMethod('delete', <String, dynamic>{'key': key});
  }

  static Future<void> deleteAll() async {
    await _channel.invokeMethod('deleteAll');
  }

  // check if key data exists
  static Future<bool> contains(String key) async {
    return await _channel
        .invokeMethod('contains', <String, dynamic>{'key': key});
  }
}
