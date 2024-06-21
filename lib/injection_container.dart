import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:petsguides/config/routes/app_route_config.dart';
import 'package:petsguides/core/util/secure_storage.dart';
import 'package:petsguides/features/auth/data/data_sources/auth_service.dart';
import 'package:petsguides/features/auth/data/repository/auth_repository_impl.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_usecase.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/map/data/data_sources/map_service.dart';
import 'package:petsguides/features/map/data/repository/map_repository_impl.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';
import 'package:petsguides/features/map/domain/usecases/map_usecase.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['baseURL']!));
  final String? languageCode = await SecureStorage.readSecureData('language');
  final locale =
      Locale(languageCode ?? Platform.localeName.substring(0, 2), '');
  sl.registerSingleton<Locale>(locale);
  sl.registerSingleton<Dio>(dio);

  // register dependencies
  sl.registerSingleton<AuthService>(AuthService(sl()));

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  //  register UseCases
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl()));

  // register Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));

  sl.registerSingleton<MapService>(MapService());
  sl.registerSingleton<MapRepository>(MapRepositoryImpl(sl()));
  sl.registerSingleton<MapUseCase>(MapUseCase(sl()));
  sl.registerFactory<MapBloc>(() => MapBloc(sl()));

  sl.registerLazySingleton<AppRouteConfig>(() => AppRouteConfig());
}
