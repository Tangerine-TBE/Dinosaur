import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:get/get.dart';

import '../../home/home_controller.dart';
import '../../pet/weight/image_preview.dart';

class LongPressPreView extends StatefulWidget {
  final List<String> images;
  final List<int> height;
  final List<int> width;
  final double size;
  final int parentIndex;
  final Function(List<String> value) onOrderUpdateCallBack;

  const LongPressPreView(
      {super.key,
      required this.parentIndex,
      required this.images,
      required this.height,
      required this.width,
      required this.size,
      required this.onOrderUpdateCallBack});

  @override
  State<LongPressPreView> createState() => _LongPressPreViewState();
}

class _LongPressPreViewState extends State<LongPressPreView> {
  final _gridViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ReorderableBuilder(
      enableDraggable: true,
      onDragStarted: () {},
      onReorder: (value) {
        for (final orderUpdateEntity in value) {
          final fruit = widget.images.removeAt(orderUpdateEntity.oldIndex);
          widget.images.insert(orderUpdateEntity.newIndex, fruit);
        }
        widget.onOrderUpdateCallBack.call(widget.images);
      },
      builder: (children) {
        return GridView(
          key: _gridViewKey,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          children: children,
        );
      },
      children: List.generate(widget.images.length, (index) {
        var tag = 'push${widget.parentIndex}0${index.toString()}';
        return Stack(
          key: Key(widget.images.elementAt(index)),
          children: [
            InkWell(
              onTap: () {
                final homeController = Get.find<HomeController>();
                homeController.toImageView(
                  widget.images[index],
                  tag,
                  widget.height[index],
                  widget.width[index],
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ImagePreView(
                  url: widget.images[index],
                  size: widget.size,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.images.removeAt(index);
                    widget.onOrderUpdateCallBack.call(widget.images);
                  });
                },
                child: Icon(
                  Icons.cancel_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
