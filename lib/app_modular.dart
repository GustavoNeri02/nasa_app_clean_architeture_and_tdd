import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/http_client/http_implementation.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/utils/keys/converters/data_to_string_converter.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/presenter/controllers/home_controller.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/presenter/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'features/data/datasources/space_media_data_source_implementation.dart';
import 'features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeController(i())),
    Bind((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind((i) => SpaceMediaRepositoryImplementation(i())),
    Bind((i) => NasaDataSourceImplementation(i())),
    Bind((i) => http.Client()),
    Bind((i) => HttpImplementation()),
    Bind((i) => DateToStringConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, __) => const HomePage()),
    ChildRoute("/picture", child: (_, args) => PicturePage.fromArgs(args)),
  ];
}
