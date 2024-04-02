import 'package:app_base/exports.dart';
import 'package:dinosaur/app/src/moudle/test/pages/imageView/image_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageViewPage extends BaseEmptyPage<ImageViewController>{
  const ImageViewPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
      return Container(child: Center(child:Image.network(controller.url)),);
  }

}