//Iniciando o TDD com redphase (write a failing test == error)
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/erros/failures.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/entities/space_media_entity.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

//utilizando o package Mock para a simulação da classe abstrata ISpaceMediaRepository;
class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

//link da api de teste => api.nasa.gov/planetary/apod?hd=true&api_key=DEMO_KEY&date=2021-02-02
  /*
  //simular um NoParams
  final tNoParams = NoParams();
  */

  test('should get space media for a given date from the repository', () async {
    // Act
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => const Right(tSpaceMedia));
    // Act
    final result = await usecase.call(tDate);
    // Assert
    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('should return a Failure when don\'t succeed', () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));
    // Act
    final result = await usecase.call(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
