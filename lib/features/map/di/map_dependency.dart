import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/features/map/data/data_sources/map_remote_datasource.dart';
import 'package:petsguides/features/map/data/repository/map_repository_impl.dart';
import 'package:petsguides/features/map/domain/usecases/map_search_places_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_select_from_search_list_usecase.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/injection_container.dart';

class MapDependency {
  MapDependency._();

  static void init() {
    sl.registerFactory(() => MapBloc(
          sl<MapSearchPlacesUseCase>(),
          sl<MapSelectFromSearchListUseCase>(),
        ));

    sl.registerLazySingleton(
        () => MapSearchPlacesUseCase(sl<MapRepositoryImpl>()));

    sl.registerLazySingleton(
        () => MapSelectFromSearchListUseCase(sl<MapRepositoryImpl>()));

    sl.registerLazySingleton(
        () => MapRepositoryImpl(sl<MapRemoteDataSourceImpl>()));

    sl.registerLazySingleton(() => MapRemoteDataSourceImpl(sl<ApiHelper>()));
  }
}
