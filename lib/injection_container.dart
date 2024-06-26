import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:petsguides/config/routes/app_route_config.dart';
import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/core/api/api_interceptor.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/core/cache/secure_local_storage.dart';
import 'package:petsguides/core/network/network_checker.dart';
import 'package:petsguides/core/util/secure_storage.dart';
import 'package:petsguides/features/auth/di/auth_dependency.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  AuthDependency.init();

  sl.registerLazySingleton(() => NetworkInfo(sl<InternetConnectionChecker>()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<AppRouteConfig>(() => AppRouteConfig());

  sl.registerLazySingleton(() => ApiHelper(sl<Dio>()));
  sl.registerLazySingleton(() => Dio()..interceptors.add(sl<ApiInterceptor>()));
  sl.registerLazySingleton(() => ApiInterceptor());

  sl.registerLazySingleton(() => HiveLocalStorage());
  sl.registerLazySingleton(
      () => SecureLocalStorage(sl<FlutterSecureStorage>()));

  // Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['baseURL']!));
  final String? languageCode = await SecureStorage.readSecureData('language');
  final locale =
      Locale(languageCode ?? Platform.localeName.substring(0, 2), '');
  sl.registerSingleton<Locale>(locale);
  // sl.registerSingleton<Dio>(dio);

  // register dependencies
  // sl.registerSingleton<AuthService>(AuthService(sl()));

  // sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // //  register UseCases
  // sl.registerSingleton<AuthUseCase>(AuthUseCase(sl()));

  // // register Blocs
  // sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

  // sl.registerSingleton<MapService>(MapService());
  // sl.registerSingleton<MapRepository>(MapRepositoryImpl(sl()));
  // sl.registerSingleton<MapUseCase>(MapUseCase(sl()));
  // sl.registerFactory<MapBloc>(() => MapBloc(sl()));
}
