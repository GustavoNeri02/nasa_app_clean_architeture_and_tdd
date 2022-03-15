//Iniciando o TDD com redphase (write a failing test == error)
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/erros/failures.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/entities/space_media_entity.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';

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
  const tSpaceMedia = SpaceMediaEntity(
      description:
          "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese",
      mediaType: "image",
      title: "A Colorful Quadrantid Meteor",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg");

  /*
  //simular um NoParams
  final tNoParams = NoParams();
  */

  final tDate = DateTime(2021, 02, 02);

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