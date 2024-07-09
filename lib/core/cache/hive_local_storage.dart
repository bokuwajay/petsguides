import 'package:hive/hive.dart';
import 'package:petsguides/core/cache/local_storage.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/util/logger.dart';

class HiveLocalStorage implements LocalStorage {
  @override
  Future<dynamic> load({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      final result = await box.get(key);
      return result;
    } catch (exception) {
      logger.e('Logger in load of Hive Local Storage:\nException: $exception\nBox Name: $boxName\nKey: $key');
      throw CacheException;
    } finally {
      box.close();
    }
  }

  @override
  Future<void> save({
    required String key,
    required dynamic value,
    String? boxName,
  }) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.put(key, value);
      return;
    } catch (exception) {
      logger.e('Logger in save of Hive Local Storage:\nException: $exception\nBox Name: $boxName\nKey: $key\nValue: $value');
      throw CacheException;
    } finally {
      box.close();
    }
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.delete(key);
      return;
    } catch (exception) {
      logger.e('Logger in delete of Hive Local Storage:\nException: $exception\nBox Name: $boxName\nKey: $key');
      throw CacheException;
    } finally {
      box.close();
    }
  }
}
