import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class Params extends Equatable {
  final String origin;
  final String destination;

  const Params({required this.origin, required this.destination});

  @override
  List<Object?> get props => [origin, destination];
}

class MapGetDirectionsUseCase implements UseCase<Map<String, dynamic>, Params> {
  final MapRepository _mapRepository;
  MapGetDirectionsUseCase(this._mapRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) async {
    if (params.origin.isEmpty || params.destination.isEmpty) {
      Failure failure = const MissingParamsFailure(suffix: 'in call of MapGetDirectionsUseCase');
      return Left(failure);
    }
    final result = await _mapRepository.getDirections(params);
    return result;
  }
}
