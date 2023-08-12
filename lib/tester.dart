import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_converter/values.dart';

// flutter build apk --release => for releasing apk
class VideoConverterWidget extends StatefulWidget {
  VideoConverterWidget({
    this.videoPath,
    required this.vBR,
    required this.q,
    required this.vF,
    required this.rH,
    required this.rW,
    super.key,
  });
  final videoPath;
  final int vBR;
  final int q;
  final String vF;
  final int rH;
  final int rW;

  @override
  _VideoConverterWidgetState createState() => _VideoConverterWidgetState();
}

class _VideoConverterWidgetState extends State<VideoConverterWidget> {
  late FlutterFFmpeg _flutterFFmpeg;
  bool _isConverting = false;
  String comment = ''; // conversion comment
  String destCommPath = '';
  @override
  void initState() {
    super.initState();
    _flutterFFmpeg = FlutterFFmpeg();
  }

  Future<bool> requestAndCreate() async {
    Directory directory;

    // 0 to convert - 1 for converting on progress
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.manageExternalStorage)) {
          directory = await getExternalStorageDirectory() as Directory;

          String newPath = "";
          // /storage/emulated/0/Android/data/com.example.video_converter/files
          List<String> folders = directory.path.split("/");
          // int x = 0;
          // while (x < 50) {
          //   print('success\n');
          //   x++;
          // }
          for (int x = 1; x < folders.length; x++) {
            if (folders[x] != "Android") {
              newPath += "/" + folders[x];
            } else {
              newPath += "/" + "VideoConverterFiles";
              break;
            }
          }
          destCommPath = newPath;
          directory = Directory(newPath);
          // print(directory.path);
        } else {
          if (await _requestPermission(Permission.storage)) {
            directory = await getTemporaryDirectory();
          }
          // openAppSettings();
          return false;
        }
        if (!await directory.exists()) {
          // if exsists checking and creating a folder
          // print('trying to create a directory');
          await directory.create(recursive: true);
          return true;
          // print('created');
        }
        // if (await directory.exists()) {
        //   File saveFile = File(directory.path + "/$fileName");
        //   await dio.download(url, saveFile.path,
        //       onReceiveProgress: (downloaded, totalSize) {
        //     setState(() {
        //       progress = downloaded / totalSize;
        //     });
        //   });
        //   return true;
        // }
      }
      return true;
    } catch (e) {
      // print('oh got an error!!');
      // print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      // print("hello ");
      return true;
    } else {
      // await openAppSettings();
      // var result1 = await Permission.accessMediaLocation.request();
      var result = await Permission.manageExternalStorage.request();

      // var result = await permission.request();
      // print(result);
      // print("checkingg");
      // print("hello 123 ");
      // print("object");

      if (result == PermissionStatus.granted) {
        // print('wonderfull');
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> convertVideoToVP9() async {
    setState(() {
      _isConverting = true;
    });
    Directory cacheDir = await getTemporaryDirectory();
    String cachePath = cacheDir.path + "/file_picker";
    List<FileSystemEntity> files = Directory(cachePath).listSync();
    print(cachePath);
    print('checkqsp222');
    for (FileSystemEntity file in files) {
      if (file is File) {
        print('File: ${file.path}');
      } else if (file is Directory) {
        print('Directory: ${file.path}');
      }
    }
    print(cachePath);
    List<String> arguments = [
      '-i',
      cachePath + "/Cycle_brought.mp4",
      cachePath + "videos.webm"
    ];
    print(cachePath);
    print(widget.videoPath);
    print('1234');
    String destination = '';
    final folders = widget.videoPath.split("/");
    for (int x = 0; x < folders.length; x++) {
      if (folders[x] == "file_picker") {
        destination = folders[x + 1];
      }
    }
    final formatRemover = destination.split('.');
    String fileName = formatRemover[0];
    final resolution = widget.rW.toString() + 'x' + widget.rH.toString();
//${widget.rW}x${widget.rH}
    ///storage/emulated/0/FlutterSak/utput.mp4
    int result = await _flutterFFmpeg.execute(
        '-i ${widget.videoPath.toString()} -s ${resolution} -c:v libvpx-vp9 -crf ${widget.q} -deadline realtime -b:v ${widget.vBR}M -b:a 128k ${destCommPath + '/' + formatRemover[0] + widget.vF}');

    print(result);
    setState(() {
      _isConverting = false;
      if (result == 0) {
        comment = 'Video conversion completed successfully!';
      } else {
        comment = 'Video conversion failed with exit code $result';
      }
    });
    _cacheClear(cachePath);
  }

  void _cacheClear(String direction) async {
    new Directory(direction).delete(recursive: true);
  }

  @override
  void dispose() {
    _flutterFFmpeg.cancel();
    //_cacheClear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hee = Values();
    return Scaffold(
      appBar: AppBar(
        title: Text('VP9 Converter'),
      ),
      body: Center(
        child: _isConverting
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "CONVERTING ...",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Convert to VP9'),
                    onPressed: _isConverting
                        ? null
                        : () async {
                            // var hi = await getTemporaryDirectory();
                            // print(hi.path);
                            await requestAndCreate();
                            // String inputPath =
                            //     ' /data/user/0/com.example.video_converter/cache/file_picker/Cycle_brought.mp4';
                            // String outputPath =
                            //     '/storage/emulated/0/FlutterSak/20230629_102714.webm';
                            convertVideoToVP9();
                          },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    comment,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}

// class SaveLocation extends StatefulWidget {
//   const SaveLocation({super.key});

//   @override
//   State<SaveLocation> createState() => _SaveLocationState();
// }

// class _SaveLocationState extends State<SaveLocation> {
//   bool loading = false;
//   final Dio dio = Dio();
//   double progress = 0.0;

//   Future<bool> saveFile(String url, String fileName) async {
//     // creating a folder
//     Directory directory;
//     try {
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory() as Directory;

//           String newPath = "";
//           // /storage/emulated/0/Android/data/com.example.video_converter/files
//           List<String> folders = directory.path.split("/");
//           int x = 0;
//           while (x < 50) {
//             print('success\n');
//             x++;
//           }
//           for (int x = 1; x < folders.length; x++) {
//             if (folders[x] != "Android") {
//               newPath += "/" + folders[x];
//             } else {
//               newPath += "/" + "FlutterSak";
//               break;
//             }
//           }
//           directory = Directory(newPath);
//           print(directory.path);
//         } else {
//           if (await _requestPermission(Permission.storage)) {
//             directory = await getTemporaryDirectory();
//           }
//           return false;
//         }
//         if (!await directory.exists()) {
//           // if exsists checking and creating a folder
//           print('trying to create a directory');
//           await directory.create(recursive: true);
//           print('created');
//         }
//         if (await directory.exists()) {
//           File saveFile = File(directory.path + "/$fileName");
//           await dio.download(url, saveFile.path,
//               onReceiveProgress: (downloaded, totalSize) {
//             setState(() {
//               progress = downloaded / totalSize;
//             });
//           });
//           return true;
//         }
//       }
//     } catch (e) {
//       print('oh got an error!!');
//       print(e);
//     }
//     return false;
//   }

//   // our interest part

//   Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       print("hello ");
//       return true;
//     } else {
//       await openAppSettings();
//       var result1 = await Permission.accessMediaLocation.request();
//       var result2 = await Permission.manageExternalStorage.request();
//       var result = await Permission.storage.request();

//       // var result = await permission.request();
//       print(result);
//       print("hello 123 ");
//       print("object");

//       if (result == PermissionStatus.granted) {
//         print('wonderfull');
//         return true;
//       } else {
//         return true;
//       }
//     }
//   }

//   downloadFile() async {
//     setState(() {
//       loading = true;
//     });

//     bool download = await saveFile(
//         "https://drive.google.com/file/d/14nJ8iF-LmuDqusJDCcAPynphlxjKnjIk/view?usp=sharing",
//         "sak.mp4");
//     if (download) {
//       print("file is downloaded");
//     } else {
//       print("file is not downloaded");
//     }

//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: loading
//             ? CircularProgressIndicator()
//             // ? LinearProgressIndicator(
//             //     minHeight: 10,
//             //     value: progress,
//             //   )
//             : ElevatedButton(
//                 child: Text('press me !!'),
//                 onPressed: downloadFile,
//               ),
//       ),
//     );
//   }
// }

// // ADD PERMISSION IN ANDROIDMANIFIEST FILE IN ANDROID/APP/MAIN

// // at build gradle need to include the external packges
