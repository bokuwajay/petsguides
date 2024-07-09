import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/core/util/logger.dart';

sealed class AuthLocalDataSource {
  Future<bool> checkSignInStatus();
  Future<bool> checkFirstLaunch();
  Future<bool> firstLaunch();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveLocalStorage _hiveLocalStorage;
  const AuthLocalDataSourceImpl(this._hiveLocalStorage);

  @override
  Future<bool> checkSignInStatus() async {
    try {
      final token = await _hiveLocalStorage.load(key: 'pgToken', boxName: 'cache');
      // there is no token (never login e.g guest user)
      if (token == null) {
        return false;
      }

      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      if (decodedToken['exp'] != null && DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000).isAfter(DateTime.now())) {
        // the token valid
        return true;
      } else {
        // token expired
        return false;
      }
    } catch (exception) {
      logger.e('Logger in checkSignInStatus of AuthLocalDataSourceImpl\nthrow: $exception');
      rethrow;
    }
  }

  @override
  Future<bool> checkFirstLaunch() async {
    try {
      final firstLaunch = await _hiveLocalStorage.load(key: 'FIRST_LAUNCH', boxName: 'cache');
      if (firstLaunch != 'pets_guides') {
        return true;
      }
      return false;
    } catch (exception) {
      logger.e('Logger in checkFirstLaunch of AuthLocalDataSourceImpl\nthrow: $exception');
      rethrow;
    }
  }

  @override
  Future<bool> firstLaunch() async {
    try {
      await _hiveLocalStorage.save(key: 'FIRST_LAUNCH', value: 'pets_guides', boxName: 'cache');
      return true;
    } catch (exception) {
      logger.e('Logger in firstLaunch of AuthLocalDataSourceImpl\nthrow: $exception');
      rethrow;
    }
  }
}
