import 'package:petsguides/core/api/api_helper.dart';
import 'package:petsguides/features/map/data/data_sources/map_remote_datasource.dart';
import 'package:petsguides/features/map/data/repository/map_repository_impl.dart';
import 'package:petsguides/features/map/domain/usecases/map_get_directions_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_get_more_places_in_radius_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_search_in_radius_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_search_places_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_select_from_search_list_usecase.dart';
import 'package:petsguides/features/map/domain/usecases/map_tap_on_carousel_card_usecase.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/injection_container.dart';

class MapDependency {
  MapDependency._();

  static void init() {
    sl.registerLazySingleton(() => MapRemoteDataSourceImpl(sl<ApiHelper>()));
    sl.registerLazySingleton(() => MapRepositoryImpl(sl<MapRemoteDataSourceImpl>()));

    sl.registerLazySingleton(() => MapSearchPlacesUseCase(sl<MapRepositoryImpl>()));
    sl.registerLazySingleton(() => MapSelectFromSearchListUseCase(sl<MapRepositoryImpl>()));
    sl.registerLazySingleton(() => MapGetDirectionsUseCase(sl<MapRepositoryImpl>()));
    sl.registerLazySingleton(() => MapSearchInRadiusUseCase(sl<MapRepositoryImpl>()));
    sl.registerLazySingleton(() => MapGetMorePlacesInRadiusUseCase(sl<MapRepositoryImpl>()));
    sl.registerLazySingleton(() => MapTapOnCarouselCardUseCase(sl<MapRepositoryImpl>()));

    sl.registerFactory(() => MapBloc(
          sl<MapSearchPlacesUseCase>(),
          sl<MapSelectFromSearchListUseCase>(),
          sl<MapGetDirectionsUseCase>(),
          sl<MapSearchInRadiusUseCase>(),
          sl<MapGetMorePlacesInRadiusUseCase>(),
          sl<MapTapOnCarouselCardUseCase>(),
        ));
  }
}
