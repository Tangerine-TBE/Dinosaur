import 'dart:async';
import 'dart:ui' as ui;

import 'package:app_base/util/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePreViewSingle extends StatefulWidget {
  final String url;
  final double size;
  ui.Image? image;
   ImagePreViewSingle({super.key, required this.url, required this.size});

  @override
  State<ImagePreViewSingle> createState() {
    return _ImagePreViewSingleState();
  }
}

class _ImagePreViewSingleState extends State<ImagePreViewSingle> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
    if(widget.image == null){
      loadImageWithUrl(widget.url, context).then(
            (value) {
          setState(() {
            widget.image = value;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image != null) {
      var imageWidth = widget.image!.width; //图片的实际宽度
      var imageHeight = widget.image!.height; //图片的实际高度
      ///比对一下图片的比例
      if (imageWidth ~/ imageHeight == 1) {
        ///正方形的图片 直接返回我们需要的实际大小的容器并包裹
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: RawImage(
            image: widget.image,
            fit: BoxFit.fill,
          ),
        );
      } else if (imageWidth ~/ imageHeight < 1) {
        /// 长方形图片，宽比高多类型，所以BoxFit。最好就是以宽优先
        return SizedBox(
          width: widget.size,
          child: RawImage(
            image: widget.image,
            fit: BoxFit.fill,
          ),
        );
      } else if (imageWidth ~/ imageHeight > 1) {
        /// 长方形图片，高比宽多类型，所以BoxFit。最好就是以高优先
        return SizedBox(
          height: widget.size,
          child: RawImage(
            image: widget.image,
            fit: BoxFit.fill,
          ),
        );
      } else {
        return SizedBox(
          height: widget.size,
          child: RawImage(
            image: widget.image,
            fit: BoxFit.fill,
          ),
        );
      }
    } else {
      return Container(
        width: widget.size,
        height: widget.size,
        color: Colors.purple,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
