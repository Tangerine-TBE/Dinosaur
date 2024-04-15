import 'package:app_base/exports.dart';
import 'package:app_base/widget/listview/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dinosaur/app/src/app.dart';
import '../sideIt/widget/charts_painter.dart';
import 'model_controller.dart';

class ModelPage extends BaseEmptyPage<ModelController>
    implements SingleTickerProviderStateMixin {
  const ModelPage({super.key});

  @override
  Color get background => Colors.white;

  @override
  Widget buildContent(BuildContext context) {
    return _buildContent02();
  }

  _buildContent02() {
    TabController tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      controller.currentModelPage.value = tabController.index;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.pageBgColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Stack(
          children: [
            TabBar(
              controller: tabController,
              dividerHeight: 0,
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              indicatorPadding: const EdgeInsets.only(left: 22, right: 22),
              indicator: const UnderlineTabIndicator(
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
                borderSide: BorderSide(
                  width: 4,
                  color: Color(0xffFF5E65),
                ),
              ),
              padding: EdgeInsets.zero,
              unselectedLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 18),
              splashFactory: NoSplash.splashFactory,
              overlayColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MyColors.scanIndicatorTextSelectedColor,
                  fontSize: 18),
              tabs: const [
                Tab(
                  text: '经典模式',
                ),
                Tab(
                  text: '我的模式',
                )
              ],
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffFF676D), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.3]),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        child: _buildContentClassic01(),
                      ),
                      Container(
                        child: _buildContentMine01(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: _buildBottomBar(),
                  flex: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBottomBar() {
    return Column(
      children: [
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 2),
            child: RepaintBoundary(
              child: CustomPaint(
                size: const Size(280, 60),
                painter: ChartsPainter(
                    process: controller.process.value.obx, processMax: 1023),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      controller.onLastClick();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        ResName.playerBack,
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onPlayClick();
                    },
                    child: Obx(
                      () => controller.playModel.value
                          ? Image.asset(
                              ResName.buttonL,
                              width: 64,
                              height: 64,
                            )
                          : Image.asset(
                              ResName.buttonR,
                              width: 64,
                              height: 64,
                            ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.onNextClick();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        ResName.playerSkip,
                        width: 36,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildContentClassic01() {
    var mainAxisAlignment = MainAxisAlignment.spaceBetween;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(0),
                _buildTemplateModelItem(1),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(2),
                _buildTemplateModelItem(3),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(4),
                _buildTemplateModelItem(5),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(6),
                _buildTemplateModelItem(7),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(8),
                _buildTemplateModelItem(9),
              ],
            ),
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                _buildTemplateModelItem(10),
                _buildTemplateModelItem(11),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildContentMine01() {
    return GetBuilder<ModelController>(
      builder: (controller) {
        return controller.modelList.isEmpty
            ? const SizedBox(
                child: NoDataWidget(
                  title: '暂无记录',
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 20,
                padding: EdgeInsets.only(left: 20, right: 20, top: 24),
                childAspectRatio: 2,
                children: List.generate(
                  controller.modelList.length,
                  (index) => _buildCustomModelItem01(
                      controller.modelList[index].name, index),
                ),
              );
      },
      id: controller.customPageId,
    );
  }

  _buildCustomModelItem01(String name, int index) {
    var isSelect = false;
    if (controller.currentCustomModel.value == index) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    return GestureDetector(
      onTap: () {
        controller.onCustomModelClick(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: !isSelect ? const Color(0xffFFD5D7) : const Color(0xffFF5E65),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ResName.path25,
              width: 69,
              height: 42,
              color: isSelect ? Colors.white : Color( 0xffFF5E65),
            ),
            SizedBox(
              width: 11,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelect ? Colors.white : Color(0xffFF5E65),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateModelItem(int index) {
    AssetImage normal;
    var isSelect = false;
    if (controller.currentClassicModel.value == index) {
      isSelect = true;
    } else {
      isSelect = false;
    }
    if (!isSelect) {
      switch (index) {
        case 0:
          normal = const AssetImage(ResName.imgNDycx);
          break;
        case 1:
          normal = const AssetImage(ResName.imgNQymm);
          break;
        case 2:
          normal = const AssetImage(ResName.imgNRyds);
          break;
        case 3:
          normal = const AssetImage(ResName.imgNYfrh);
          break;
        case 4:
          normal = const AssetImage(ResName.imgNNgsh);
          break;
        case 5:
          normal = const AssetImage(ResName.imgNQsyh);
          break;
        case 6:
          normal = const AssetImage(ResName.imgNMlmh);
          break;
        case 7:
          normal = const AssetImage(ResName.imgBYbbn);
          break;
        case 8:
          normal = const AssetImage(ResName.imgNKlwj);
          break;
        case 9:
          normal = const AssetImage(ResName.imgNYszh);
          break;
        case 10:
          normal = const AssetImage(ResName.imgNXhnf);
          break;
        case 11:
          normal = const AssetImage(ResName.imgNGdck);
          break;
        default:
          normal = const AssetImage(ResName.imgNDycx);
          break;
      }
    } else {
      switch (index) {
        case 0:
          normal = const AssetImage(ResName.imgYDycx);
          break;
        case 1:
          normal = const AssetImage(ResName.imgYQymm);
          break;
        case 2:
          normal = const AssetImage(ResName.imgYRyds);
          break;
        case 3:
          normal = const AssetImage(ResName.imgYYfrh);
          break;
        case 4:
          normal = const AssetImage(ResName.imgYNqsh);
          break;
        case 5:
          normal = const AssetImage(ResName.imgYQsyh);
          break;
        case 6:
          normal = const AssetImage(ResName.imgYMlmh);
          break;
        case 7:
          normal = const AssetImage(ResName.imgYYbbn);
          break;
        case 8:
          normal = const AssetImage(ResName.imgYKlwj);
          break;
        case 9:
          normal = const AssetImage(ResName.imgYYszh);
          break;
        case 10:
          normal = const AssetImage(ResName.imgYXhnf);
          break;
        case 11:
          normal = const AssetImage(ResName.imgYGdck);
          break;
        default:
          normal = const AssetImage(ResName.imgYDycx);
          break;
      }
    }

    return GestureDetector(
      onTap: () {
        controller.onClassicItemClick(index);
      },
      child: Container(
        width: 144,
        height: 83,
        decoration: BoxDecoration(
          image: DecorationImage(image: normal),
        ),
      ),
    );
  }

  @override
  void activate() {}

  @override
  BuildContext get context => throw UnimplementedError();

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {}

  @override
  void dispose() {}

  @override
  void initState() {}

  @override
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {}

  @override
  void setState(VoidCallback fn) {}

  @override
  StatefulWidget get widget => throw UnimplementedError();
}
