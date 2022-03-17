import 'dart:convert';

import 'package:nasa_app_clean_architeture_and_tdd/core/erros/exceptions.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/http_client/http_client.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/utils/keys/converters/data_to_string_converter.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/datasources/space_media_data_source.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/models/space_media_model.dart';

class NasaDataSourceImplementation implements ISpaceMediaDataSource {
  final HttpClient client;

  NasaDataSourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
