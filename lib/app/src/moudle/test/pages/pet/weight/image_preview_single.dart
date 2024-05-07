import 'dart:ui' as ui;

import 'package:app_base/exports.dart';
import 'package:app_base/res/my_colors.dart';
import 'package:app_base/util/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagePreViewSingle extends StatefulWidget {
  final String url;
  final double size;
  final int imageWidth;
  final int imageHeight;

  const ImagePreViewSingle(
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
  Widget build(BuildContext context) {
    super.build(context);
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
          child: CachedNetworkImage(
            imageUrl: widget.url,
            placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 40, // 统一设置指示器的大小
                  height: 40,
                  child: CircularProgressIndicator(strokeWidth: 2,color: MyColors.themeTextColor,),
                ),
            ),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
    }
  }

  Widget buildImageViewWithHeight() {
    var boxHeight = widget.size * widget.imageHeight / widget.imageWidth;
    return SizedBox(
      width: widget.size,
      height: boxHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: widget.url,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 40, // 统一设置指示器的大小
              height: 40,
              child: CircularProgressIndicator(strokeWidth: 2,color: MyColors.themeTextColor,),
            ),
          ),
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget buildImageViewWithWidth() {
    double boxWidth = widget.size * widget.imageWidth / widget.imageHeight;

    return SizedBox(
      width: boxWidth,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: widget.url,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 40, // 统一设置指示器的大小
              height: 40,
              child: CircularProgressIndicator(strokeWidth: 2,color: MyColors.themeTextColor,),
            ),
          ),
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
