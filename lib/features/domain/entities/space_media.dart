import 'package:equatable/equatable.dart';

//entidade SpaceImage
class SpaceMedia extends Equatable {
  final String description;
  final String mediaType;
  final String title;
  final String mediaUrl;

  const SpaceMedia(
      {required this.description,
      required this.mediaType,
      required this.title,
      required this.mediaUrl});

  @override
  List<Object?> get props => [description, mediaType, title, mediaUrl];
}
