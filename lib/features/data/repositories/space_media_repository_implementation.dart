import 'package:nasa_app_clean_architeture_and_tdd/features/data/datasources/space_media_data_source.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/entities/space_media_entity.dart';

import 'package:nasa_app_clean_architeture_and_tdd/core/erros/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../core/erros/exceptions.dart';
import '../../domain/repositories/space_media_repository.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDataSource dataSource;

  SpaceMediaRepositoryImplementation(this.dataSource);

  //força a seguir o contrato do domain
  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await dataSource.getSpaceMediaFromDate(date);
      return Right(result);
      // ignore: empty_catches
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
