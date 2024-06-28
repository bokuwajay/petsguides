import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/util/logger.dart';

sealed class AuthLocalDataSource {
  Future<bool> checkFirstLaunch();
  Future<bool> checkSignInStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveLocalStorage _hiveLocalStorage;
  const AuthLocalDataSourceImpl(
    this._hiveLocalStorage,
  );

  @override
  Future<bool> checkSignInStatus() async {
    try {
      final token = await _hiveLocalStorage.load(
        key: 'pgToken',
        boxName: 'cache',
      );
      // there is a token
      if (token != null) {
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        // the token is not expired
        if (decodedToken['exp'] != null &&
            DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000)
                .isAfter(DateTime.now())) {
          return true;
        } else {
          // there is a token, but expired
          return false;
        }
      } else {
        // there is no token (never login e.g guest user)
        return false;
      }
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }

  @override
  Future<bool> checkFirstLaunch() async {
    try {
      final firstLaunch = await _hiveLocalStorage.load(
        key: 'FIRST_LAUNCH',
        boxName: 'cache',
      );
      if (firstLaunch != 'pets_guides') {
        return true;
      }
      return false;
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }
}
