import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:petsguides/features/auth/data/data_sources/auth_service.dart';
import 'package:petsguides/features/auth/data/repository/auth_repository_impl.dart';
import 'package:petsguides/features/auth/domain/repository/auth_repository.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_usecase.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  Dio dio = Dio(BaseOptions(baseUrl: dotenv.env['baseURL']!));
  sl.registerSingleton<Dio>(dio);

  // register dependencies
  sl.registerSingleton<AuthService>(AuthService(sl()));

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  //  register UseCases
  sl.registerSingleton<AuthUseCase>(AuthUseCase(sl()));

  // register Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
}
