import 'package:flutter/material.dart';
import 'package:video_converter/rate_buttons.dart';
import 'package:video_converter/video_file.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.videoPath, super.key});
  final videoPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('VP9 video Converter')),
      resizeToAvoidBottomInset: false,
      body: MainPage(videoPath),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage(this.videoPath, {super.key});
  String videoPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            VideoSelector(
              videoPath: videoPath,
            ),
            RateButtons(videoPath: videoPath),
          ],
        ),
      ),
    );
  }
}
