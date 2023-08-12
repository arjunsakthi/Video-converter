import 'package:flutter/material.dart';

class Values extends ChangeNotifier {
  String rH = '';
  String rW = '';
  void getting(value) {
    print('object123');
    print(value);
    rH = value;
  }
}
