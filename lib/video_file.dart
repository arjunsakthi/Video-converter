// flutter pub add file_picker
// flutter pub add video_player

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_converter/video_player_app.dart';
import 'package:video_player/video_player.dart';

class VideoSelector extends StatefulWidget {
  VideoSelector({required this.videoPath, super.key});
  String videoPath;
  @override
  State<VideoSelector> createState() => _VideoSelectorState();
}

class _VideoSelectorState extends State<VideoSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      child: VideoPlayerApp( videoPath: widget.videoPath),
    ); /*
        child: DecoratedBox(decoration:BoxDecoration(border: Border()), child: Icon(Icons.add)),
        child: ElevatedButton(
          onPressed: openVideo,
          child: Text('Open Video'),
        ),*/
  }
}
