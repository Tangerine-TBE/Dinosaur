import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Future<ui.Image> loadImageWithUrl(String url, BuildContext context) async {
  Image image = Image.network(url);
  Completer<ui.Image> completer = Completer<ui.Image>();
  image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }),
  );
  await precacheImage(image.image, context);
  return completer.future;
}
