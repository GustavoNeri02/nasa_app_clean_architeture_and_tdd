import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/presenter/controllers/home_controller.dart';
import 'package:nasa_app_clean_architeture_and_tdd/features/presenter/widgets/custom_shimmer.dart';

import '../../domain/entities/space_media_entity.dart';
import '../widgets/description_bottom_sheet.dart';
import '../widgets/image_network_with_loader.dart';

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;

  PicturePage.fromArgs(dynamic arguments, {Key? key}) : super(key: key) {
    dateSelected = arguments.data['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed(
      '/picture',
      arguments: {'dateSelected': dateSelected},
    );
  }

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeController> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaFromDate(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScopedBuilder(
        store: store,
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Text(
            'An error occurred, try again later.\n${error.toString()}',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white),
          ),
        ),
        onState: (context, SpaceMediaEntity spaceMedia) {
          return GestureDetector(
            onVerticalDragUpdate: (update) {
              if (update.delta.dy < 0) {
                showDescriptionBottomSheet(
                  context: context,
                  title: spaceMedia.title,
                  description: spaceMedia.description,
                );
              }
            },
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: spaceMedia.mediaType == 'video'
                      ? const Center(
                          child: Text("Can't play the video"),
                        )
                      : spaceMedia.mediaType == 'image'
                          ? ImageNetworkWithLoader(
                              url: spaceMedia.mediaUrl,
                            )
                          : Container(),
                ),
                Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: CustomShimmer(
                        child: Column(
                      children: [
                        const Icon(
                          Icons.keyboard_arrow_up,
                          size: 35,
                        ),
                        Text(
                          "Slide up to see the description",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
