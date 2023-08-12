import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_converter/home_page.dart';
import 'package:video_converter/rate_buttons.dart';
import 'package:video_converter/tester.dart';
import 'package:video_converter/values.dart';

import 'package:video_converter/video_file.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: openVideo(),
    ),
  );
}

class openVideo extends StatelessWidget {
  const openVideo({super.key});

  @override
  Widget build(BuildContext context) {
    String videoPath;
    void openVideo() async {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      ) as FilePickerResult;

      if (result != null) {
        videoPath = result.files.single.path as String;
        var actualPath = await File(videoPath);
        print('checkqsp1');
        print(videoPath);
        Directory appDocDir = await getExternalStorageDirectory() as Directory;

        Directory directory = await getApplicationDocumentsDirectory();
        print(directory.path);
        String newPath = directory.path + "/flutter_assests";
        directory = Directory(
            '/data/user/0/com.example.video_converter/cache/file_picker');
        print(directory.path);

        List<FileSystemEntity> files = directory.listSync();

        for (FileSystemEntity file in files) {
          if (file is File) {
            print('File: ${file.path}');
          } else if (file is Directory) {
            print('Directory: ${file.path}');
          }
        }

        print(actualPath.path);
        print('object');
        print(result.files[0].path);
        print(videoPath);
        // Handle the selected video file path
        // You can display the video or perform any required operations
        // For example, you can pass the video path to a video player widget
        /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => */

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => // VideoConverterWidget(),
                HomePage(
              videoPath: videoPath,
            ),
          ),
        );
      } else {
        // User canceled the file picking operation
      }
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'VP9 Video Converter',
            textAlign: TextAlign.center,
          )),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            openVideo();
          },
          child: Text('Open Video'),
        ),
      ),
    );
  }
}
