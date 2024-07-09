import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petsguides/core/cache/local_storage.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/util/logger.dart';

class SecureLocalStorage implements LocalStorage {
  final FlutterSecureStorage _storage;
  const SecureLocalStorage(this._storage);

  @override
  Future<dynamic> load({required String key, String? boxName}) async {
    try {
      final result = await _storage.read(key: key);
      return result;
    } catch (exception) {
      logger.e('Logger in load of Secure Local Storage:\nException: $exception\nBox Name: $boxName\nKey: $key');
      throw CacheException;
    }
  }

  @override
  Future<void> save({
    required String key,
    required value,
    String? boxName,
  }) async {
    try {
      final result = await _storage.write(key: key, value: value);
      return result;
    } catch (exception) {
      logger.e('Logger in save of Secure Local Storage:\nException: $exception\nBox Name: $boxName\nKey: $key\nValue: $value');
      throw CacheException;
    }
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    try {
      await _storage.delete(key: key);
      return;
    } catch (exception) {
      logger.e('Logger in delete of Secure Local Storage:\nException: $exception\nBox Name: $boxName\nKey: $key');
      throw CacheException;
    }
  }
}
