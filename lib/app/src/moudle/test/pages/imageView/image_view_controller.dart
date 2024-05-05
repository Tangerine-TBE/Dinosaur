import 'dart:ui';
import 'package:flutter/cupertino.dart';

enum Model { picTransformScale, unKnow }

class ImageViewController   {
  Offset position = const Offset(0, 0);
  Offset dragStartPosition = const Offset(0, 0);
  var canDrag = false;
  var canDoubleTap = false;
  var pointerDrag = true;
  Model dragModel = Model.unKnow;
  TransformationController transformationController =
      TransformationController();

   close() {
    transformationController.dispose();
  }
}
