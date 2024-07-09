import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class Params extends Equatable {
  final String nextPageToken;

  const Params({required this.nextPageToken});

  @override
  List<Object?> get props => [nextPageToken];
}

class MapGetMorePlacesInRadiusUseCase implements UseCase<Map<String, dynamic>, Params> {
  final MapRepository _mapRepository;

  MapGetMorePlacesInRadiusUseCase(this._mapRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) async {
    if (params.nextPageToken.isEmpty) {
      Failure failure = const MissingParamsFailure(suffix: 'in call of MapGetMorePlacesInRadiusUseCase');
      return Left(failure);
    }

    final result = await _mapRepository.getMorePlacesInRadius(params);
    return result;
  }
}
