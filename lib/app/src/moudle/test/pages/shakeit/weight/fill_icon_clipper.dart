import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/services.dart' show rootBundle;
import 'package:app_base/exports.dart';
import 'package:image/image.dart';

late Paint mPaint;

class FillIconClipper extends CustomClipper<Rect>{
  final double offsetValue;
  final int vector;
  FillIconClipper({required this.offsetValue,required this.vector});
  @override
  Rect getClip(Size size) {
    double offsetWidth  = size.width/vector * offsetValue;
    if(offsetWidth > size.width){
      offsetWidth = size.width;
    }
    return Rect.fromLTRB(0, 0, offsetWidth, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }


}