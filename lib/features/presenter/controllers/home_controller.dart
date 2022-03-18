import 'package:dartz/dartz.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_app_clean_architeture_and_tdd/core/erros/failures.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/entities/space_media_entity.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeController extends StreamStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeController(this.usecase)
      : super(const SpaceMediaEntity(
            description: "", mediaType: "", title: "", mediaUrl: ""));

  getSpaceMediaFromDate(DateTime? tDate) async {
    setLoading(true);
    final result = await usecase(tDate);
    result.fold((error) => setError(error), (success) => update(success));
    setLoading(false);

    //executeEither(() =>
    //    usecase(tDate) as Future<EitherAdapter<Failure, SpaceMediaEntity>>);
  }
}
