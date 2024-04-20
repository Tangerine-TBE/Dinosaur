import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/chart_bean.dart';
import 'package:app_base/mvvm/repository/chart_repo.dart';
import 'package:get/get.dart';

class ChartController extends BaseController {
  late SingleCharManager singleCharManager;
  late DoubleCharManager doubleCharManager;
  late SpecialCharManager specialCharManager;
  final chartRepo = Get.find<ChartRepo>();

  @override
  void onInit() {
    singleCharManager = SingleCharManager(controller: this);
    doubleCharManager = DoubleCharManager(controller: this);
    specialCharManager = SpecialCharManager(controller: this);
    singleCharManager.init();
    super.onInit();
  }

  onPageChanged(int index) {
    if (index == 0) {
      singleCharManager.init();
    } else if (index == 1) {
      doubleCharManager.init();
    } else if (index == 2) {
      specialCharManager.init();
    }
  }
}

class SingleCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 1;
  final data = <WaveList>[];

  SingleCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    final response = await controller.apiLaunch(
      () => controller.chartRepo.getCharts(
        ChartReq(
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            type: 'Single'),
      ),
    );
    if (response?.data?.waveList != null) {
      data.addAll(response!.data!.waveList);
      controller.update([chartListId]);
    }
  }

  onChartItemClick(int index) {
    controller.navigateTo(RouteName.waveDemo);
    // controller.update([chartListId]);
  }

  onChartLikeClicked(int index) {
    // data[index].like = !data[index].like;
    // controller.update([chartListId]);
  }

  onChartLinkClicked(int index) {
    // data[index].link = !data[index].link;
    // controller.update([chartListId]);
  }
}

class DoubleCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 2;
  final data = <WaveList>[];

  DoubleCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }
  getChartList() async {
    final response = await controller.apiLaunch(
          () => controller.chartRepo.getCharts(
        ChartReq(
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            type: 'Double'),
      ),
    );
    if (response?.data?.waveList != null) {
      data.addAll(response!.data!.waveList);
      controller.update([chartListId]);
    }
  }

  onChartItemClick(int index) {
    controller.update([chartListId]);
  }

  onChartLikeClicked(int index) {
    // data[index].like = !data[index].like;
    // controller.update([chartListId]);
  }

  onChartLinkClicked(int index) {
    // data[index].link = !data[index].link;
    // controller.update([chartListId]);
  }
}

class SpecialCharManager {
  bool isInit = false;
  final ChartController controller;
  final chartListId = 2;
  final data = <WaveList>[];

  SpecialCharManager({required this.controller});

  init() {
    if (!isInit) {
      getChartList();
      isInit = true;
    }
  }

  getChartList() async {
    final response = await controller.apiLaunch(
          () => controller.chartRepo.getCharts(
        ChartReq(
            pageIndex: 1,
            pageSize: 10,
            orderBy: 'createTime desc',
            type: 'Suction'),
      ),
    );
    if (response?.data?.waveList != null) {
      data.addAll(response!.data!.waveList);
      controller.update([chartListId]);
    }
  }

  onChartItemClick(int index) {
    controller.update([chartListId]);
  }

  onChartLikeClicked(int index) {
    // data[index].like = !data[index].like;
    // controller.update([chartListId]);
  }

  onChartLinkClicked(int index) {
    // data[index].link = !data[index].link;
    // controller.update([chartListId]);
  }
}
