import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/core/cache/hive_local_storage.dart';
import 'package:petsguides/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:petsguides/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:petsguides/features/auth/data/repository/auth_repository_impl.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_check_first_launch_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_check_signin_status_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_first_launch_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_usecase.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/injection_container.dart';

class AuthDependency {
  AuthDependency._();

  static void init() {
    sl.registerLazySingleton(() => AuthLocalDataSourceImpl(sl<HiveLocalStorage>()));
    sl.registerLazySingleton(() => AuthRemoteDataSourceImpl(sl<ApiHelper>()));

    sl.registerLazySingleton(() => AuthRepositoryImpl(
          sl<AuthRemoteDataSourceImpl>(),
          sl<AuthLocalDataSourceImpl>(),
          sl<HiveLocalStorage>(),
        ));

    sl.registerLazySingleton(() => AuthUseCase(sl<AuthRepositoryImpl>()));
    sl.registerLazySingleton(() => AuthCheckSignInStatusUseCase(sl<AuthRepositoryImpl>()));
    sl.registerLazySingleton(() => AuthFirstLaunchUseCase(sl<AuthRepositoryImpl>()));
    sl.registerLazySingleton(() => AuthCheckFirstLaunchUseCase(sl<AuthRepositoryImpl>()));

    sl.registerFactory(() => AuthBloc(
          sl<AuthUseCase>(),
          sl<AuthCheckSignInStatusUseCase>(),
          sl<AuthFirstLaunchUseCase>(),
          sl<AuthCheckFirstLaunchUseCase>(),
        ));
  }
}
