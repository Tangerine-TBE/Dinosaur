import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';

Future<ui.Image> loadImageWithUrl(String url, BuildContext context) async {
  Image image = Image.network(url);
  Completer<ui.Image> completer = Completer<ui.Image>();
  image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }),
  );
  return completer.future;
}
Future<ui.Image> loadImageWithPath(String path,BuildContext context) async{
  Image image = Image.file(File(path));
  Completer<ui.Image> completer = Completer<ui.Image>();
  image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }),
  );
  return completer.future;
}

Widget loadImage(String url, double width, double height) {
  try {
    return url.isNotEmpty
        ? Image.network(
            url,
            width: width,
            height: height,
          )
        : Image.asset(
            ResName.loaded_failure,
            width: width,
            height: height,
          );
  }catch (e){
    return Image.asset(
      ResName.loaded_failure,
      width: width,
      height: height,
    );
  }
}
