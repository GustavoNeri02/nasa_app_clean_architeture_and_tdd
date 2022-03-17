import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/presenter/controllers/home_controller.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeController controller;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediaFromDateUsecase();
    controller = HomeController(mockUsecase);
  });

  test("should return a SpaceMedia from the usecase", () async {
    // Arrange
    when(() => mockUsecase(any())).thenAnswer((_) async => Right(tSpaceMedia));
    // Act
    controller.getSpaceMediaFromDate(tDate);
    // Assert
  });
}
