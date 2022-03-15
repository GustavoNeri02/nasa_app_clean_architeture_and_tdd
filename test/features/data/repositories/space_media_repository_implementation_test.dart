import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/erros/exceptions.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/erros/failures.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/datasources/space_media_data_source.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/models/space_media_model.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDataSource extends Mock implements ISpaceMediaDataSource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDataSource dataSource;

  setUp(() {
    dataSource = MockSpaceMediaDataSource();
    repository = SpaceMediaRepositoryImplementation(dataSource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
      description: """
Meteors can be colorful. While the human eye usually cannot discern many colors,
 cameras often can. Pictured is a Quadrantids meteor captured by camera over 
 Missouri, USA, early this month that was not only impressively bright, but 
 colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a 
 path across Earth's atmosphere.  Colors in meteors usually originate from 
 ionized elements released as the meteor disintegrates, with blue-green 
 typically originating from magnesium, calcium radiating violet, and nickel 
 glowing green. Red, however, typically originates from energized nitrogen and 
 oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a 
 flash -- less than a second -- but it left a wind-blown ionization trail that 
 remained visible for several minutes.   APOD is available via Facebook: in 
 English, Catalan and Portuguese""",
      mediaType: "image",
      title: "A Colorful Quadrantid Meteor",
      mediaUrl:
          "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg");

  final tDate = DateTime(2021, 02, 02);

  test('should return space media model when calls the data source', () async {
    // Arrange
    when(() => dataSource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => dataSource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return a server failure when the call to datasource is unsuccessful',
      () async {
    // Arrange
    when(() => dataSource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => dataSource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
