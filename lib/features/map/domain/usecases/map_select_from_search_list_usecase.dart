import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:petsguides/core/error/failures.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/features/map/domain/repository/map_repository.dart';

class Params extends Equatable {
  final String placeId;

  const Params({required this.placeId});

  @override
  List<Object?> get props => [placeId];
}

class MapSelectFromSearchListUseCase implements UseCase<Map<String, dynamic>, Params> {
  final MapRepository _mapRepository;
  MapSelectFromSearchListUseCase(this._mapRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) async {
    if (params.placeId.isEmpty) {
      return Left(MissingParamsFailure());
    }

    final result = await _mapRepository.selectFromSearchList(params);
    return result;
  }
}
