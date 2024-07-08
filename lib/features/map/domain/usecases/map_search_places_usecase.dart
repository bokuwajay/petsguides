import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/map/domain/entities/auto_complete_entity.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class Params extends Equatable {
  final String searchInput;

  const Params({required this.searchInput});

  @override
  List<Object?> get props => [searchInput];
}

class MapSearchPlacesUseCase implements UseCase<List<AutoCompleteEntity>, Params> {
  final MapRepository _mapRepository;
  MapSearchPlacesUseCase(this._mapRepository);

  @override
  Future<Either<Failure, List<AutoCompleteEntity>>> call(Params params) async {
    if (params.searchInput.isEmpty) {
      return const Left(MissingParamsFailure('in call of MapSearchPlacesUseCase'));
    }
    final result = await _mapRepository.searchPlaces(params);
    return result;
  }
}
