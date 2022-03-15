import 'package:dartz/dartz.dart';

import '../../../core/erros/failures.dart';
import '../entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
