import 'package:flutter/material.dart';
import 'package:video_converter/tester.dart';
import 'package:video_player/video_player.dart';

class RateButtons extends StatefulWidget {
  RateButtons({this.videoPath, super.key});
  final videoPath;
  final bitRate = TextEditingController();
  var videoFormat = '.mp4';
  final quality = TextEditingController();
  int get vBR => int.parse(bitRate.text);
  int get q => int.parse(quality.text);
  String get vF => videoFormat;
  @override
  State<RateButtons> createState() =>
      _RateButtonsState(bitRate, videoFormat, quality);
}

class _RateButtonsState extends State<RateButtons> {
  _RateButtonsState(this._bitRate, this._videoFormat, this._quality);
  TextEditingController resolutionHeight = TextEditingController();
  TextEditingController resolutionWidth = TextEditingController();
  final _bitRate;
  var _videoFormat;
  final _quality;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: _bitRate,
                    decoration: InputDecoration(
                      suffix: Text(
                        'M',
                        style: TextStyle(color: Colors.black),
                      ),
                      helperStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Text(
                    'Video Bitrate',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 50,
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: _quality,
                    decoration: InputDecoration(
                      helperStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Text(
                    'Quality',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 90,
              height: 105,
              child: Column(
                children: [
                  InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isDense: true,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: _videoFormat,
                          items: const [
                            DropdownMenuItem(
                              value: '.mp4',
                              child: Text('.mp4'),
                            ),
                            DropdownMenuItem(
                              value: '.mov',
                              child: Text('.mov'),
                            ),
                            DropdownMenuItem(
                              value: '.avi',
                              child: Text('.avi'),
                            ),
                            DropdownMenuItem(
                              value: '.mkv',
                              child: Text('.mkv'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _videoFormat = value as String;
                            });
                          }),
                    ),
                  ),
                  Text(
                    'Format',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 65,
              child: Column(
                children: [
                  TextField(
                    controller: resolutionWidth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            Container(
              height: 65,
              width: 50,
              child: Center(
                child: Text(
                  'X',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 100,
              height: 65,
              child: Column(
                children: [
                  TextField(
                    controller: resolutionHeight,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text('Resolution'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // RateButtons state1 = RateButtons();
                // ResolutionButton state2 = ResolutionButton();
                // int videoBitrate;
                // int quality;
                // String format;
                // String esolutionHeight;
                // String resolutionWidth;
                // // print(state1.q);
                // //videoBitrate = state1.vBR;
                // //print(videoBitrate);
                // // quality = int.parse(state1.q);
                // //format = state1.vF;
                // esolutionHeight = ResolutionButton().hi;
                // print(Values.);

                // // resolutionWidth = state2.rW;
                // print('hello');
                //print(videoBitrate);
                //print(quality);
                // print(format);
                // print(resolutionHeight);
                // print(resolutionWidth);
                if (_bitRate.text != '' &&
                    _quality.text != '' &&
                    resolutionHeight.text != '' &&
                    resolutionWidth.text != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoConverterWidget(
                        videoPath: widget.videoPath,
                        vBR: int.parse(_bitRate.text),
                        q: int.parse(_quality.text),
                        vF: _videoFormat,
                        rH: int.parse(resolutionHeight.text),
                        rW: int.parse(resolutionWidth.text),
                      ),
                      //     HomePage(
                      //   videoPath: videoPath,
                      // ),
                    ),
                  );
                }
              },
              icon: Icon(Icons.arrow_forward),
              label: Text(
                'Convert',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
