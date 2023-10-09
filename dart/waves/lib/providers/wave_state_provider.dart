import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class Wave with ChangeNotifier {
  bool _isEditing = false;
  bool _isSlideBarVisible = false;
  double _isPaylasVisible = 1.0;
  double _rotation = 0.0;

  bool get isEditing => _isEditing;
  bool get isSlideBarVisible => _isSlideBarVisible;
  double get isPaylasVisible => _isPaylasVisible;
  double get rotation => _rotation;

  set opacity(double opacity) {
    _isPaylasVisible = opacity;
    notifyListeners();
  }

  void toggleEditStatus() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void toggleSlideBarVisibility() {
    _isSlideBarVisible = !_isSlideBarVisible;
    notifyListeners();
  }

  set setRotation(double newRotation) {
    _rotation = newRotation;
    notifyListeners();
  }

  Future<File> createWave(BuildContext context, GlobalKey screen) async {
    int randomize = Random().nextInt(100);
    RenderRepaintBoundary boundary = screen.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = File('$directory/screenshot$randomize.png');
    await imgFile.writeAsBytes(pngBytes);
    return imgFile;
  }
}
