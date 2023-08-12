import 'package:flutter/material.dart';
import 'package:video_converter/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({required this.controller, super.key});
  final VideoPlayerController controller;
  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Center(
              child: Container(
                height: 300,
                width: double.infinity,
                alignment: Alignment.center,
                child: buildVideo(),
              ),
            )
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(
              child: BasicOverlayWidget(
            controller: controller,
          ))
        ],
      );
  Widget buildVideoPlayer() => VideoPlayer(controller);
}
