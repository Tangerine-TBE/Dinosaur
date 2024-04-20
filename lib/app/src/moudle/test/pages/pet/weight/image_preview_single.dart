import 'dart:async';
import 'dart:ui' as ui;

import 'package:app_base/exports.dart';
import 'package:app_base/util/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePreViewSingle extends StatefulWidget {
  final String url;
  final double size;
  final int imageWidth;
  final int imageHeight;
  ui.Image? image;

  ImagePreViewSingle(
      {super.key,
      required this.url,
      required this.size,
      required this.imageWidth,
      required this.imageHeight});

  @override
  State<ImagePreViewSingle> createState() {
    return _ImagePreViewSingleState();
  }
}

class _ImagePreViewSingleState extends State<ImagePreViewSingle>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    loadImage();
  }

  loadImage() {
    if (widget.image == null) {
      if (widget.url.startsWith('http')) {
        loadImageWithUrl(widget.url, context).then(
          (value) {
            setState(
              () {
                widget.image = value;
              },
            );
          },
        );
      } else {
        loadImageWithPath(widget.url, context).then(
          (value) {
            setState(
              () {
                widget.image = value;
              },
            );
          },
        );
      }
    }
  }

  @override
  void didUpdateWidget(covariant ImagePreViewSingle oldWidget) {
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    var imageWidth = widget.imageWidth; //图片的实际宽度
    var imageHeight = widget.imageHeight;
    if (imageWidth > imageHeight) {
      return buildImageViewWithHeight();
    } else if (imageWidth < imageHeight) {
      return buildImageViewWithWidth();
    } else {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: RawImage(
            image: widget.image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget buildImageViewWithHeight() {
    var boxHeight = widget.size * widget.imageHeight/ widget.imageWidth ;
    return widget.image == null
        ? SizedBox(
            width: widget.size,
            height: boxHeight,
          )
        : SizedBox(
            width: widget.size,
            height: boxHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: RawImage(
                image: widget.image,
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  Widget buildImageViewWithWidth() {
    double boxWidth = widget.size*widget.imageWidth / widget.imageHeight ;

    return widget.image == null
        ? SizedBox(
      width: boxWidth,
      height: widget.size,
    )
        : SizedBox(
      width: boxWidth,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: RawImage(
          image: widget.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
