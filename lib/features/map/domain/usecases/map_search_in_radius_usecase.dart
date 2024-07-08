import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class Params extends Equatable {
  final LatLng tappedPoint;
  final int radius;

  const Params({required this.tappedPoint, required this.radius});

  @override
  List<Object?> get props => [tappedPoint, tappedPoint];
}

class MapSearchInRadiusUseCase implements UseCase<Map<String, dynamic>, Params> {
  final MapRepository _mapRepository;
  MapSearchInRadiusUseCase(this._mapRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) async {
    if (params.props.isEmpty) {
      return const Left(MissingParamsFailure('in call of MapSearchInRadiusUseCase'));
    }
    final result = await _mapRepository.searchInRadius(params);
    return result;
  }
}
