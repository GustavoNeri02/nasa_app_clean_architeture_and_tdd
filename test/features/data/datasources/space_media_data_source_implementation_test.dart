import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/erros/exceptions.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/http_client/http_client.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/utils/keys/converters/data_to_string_converter.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/datasources/space_media_data_source.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/datasources/space_media_data_source_implementation.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDataSource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDataSourceImplementation(client);
  });

  final tDateTime = DateTime(2021, 02, 02);
  const urlExpected =
      "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-02";

  DateToStringConverter.convert(tDateTime);

  void secessMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test("Should call the get mehod with correct url", () async {
    // Arrange
    secessMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(
      () => client.get(urlExpected),
    ).called(1);
  });

  test("Should return a SmaceMediaModel when is successful", () async {
    // Arrange
    secessMock();
    const tSpaceMediaModelExpected = SpaceMediaModel(
        description:
            "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese",
        mediaType: "image",
        title: "A Colorful Quadrantid Meteor",
        mediaUrl:
            "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg");
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModelExpected);
  });

  test("Should throw a ServerException when the call is unccessful", () async {
    // Arrange
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: "something went wrong", statusCode: 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
  });
}
