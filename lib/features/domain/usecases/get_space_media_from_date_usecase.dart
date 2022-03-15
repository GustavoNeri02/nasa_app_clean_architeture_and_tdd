import 'package:nasa_app_clean_architeture_and_tdd/core/erros/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../entities/space_media_entity.dart';
import '../repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements UseCase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date);
  }
}
