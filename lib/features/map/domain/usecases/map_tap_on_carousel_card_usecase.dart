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

class MapTapOnCarouselCardUseCase implements UseCase<Map<String, dynamic>, Params> {
  final MapRepository _mapRepository;
  MapTapOnCarouselCardUseCase(this._mapRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Params params) async {
    if (params.placeId.isEmpty) {
      return Left(MissingParamsFailure());
    }
    final result = await _mapRepository.tapOnCarouselCard(params);
    return result;
  }
}
