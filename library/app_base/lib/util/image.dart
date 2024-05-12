import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

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
Future<Uint8List> compressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 70,

  );
  return result??Uint8List(0);
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

Widget loadImageByPath(String path ,double width,double height){
  return  Image.file(
    File(path),
    width: width,
    height: height,
  );
}

ImageProvider loadImageProvider(String url) {
  if (url.isEmpty) {
    return const AssetImage(ResName.loaded_failure);
  } else {
    try {
      return NetworkImage(url);
    } catch (e) {
      return const AssetImage(ResName.loaded_failure);
    }
  }
}