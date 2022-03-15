import '../models/space_media_model.dart';

abstract class ISpaceMediaDataSource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
