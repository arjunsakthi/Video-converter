import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_converter/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatefulWidget {
  VideoPlayerApp({required this.videoPath, super.key});
  String videoPath;
  @override
  State<VideoPlayerApp> createState() => _VideoPlayerAppState();
}

class _VideoPlayerAppState extends State<VideoPlayerApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.pause()); // then waits for previous work to be complete and does thing
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget( controller: _controller);
  }
}
