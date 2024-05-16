import 'package:app_base/exports.dart';
import 'package:get/get.dart';
class MineController extends BaseController {
  final avatorId = 1;
  final nickNameId = 2;
  List<ItemBean> buildTitleItem() {
    var list = <ItemBean>[];
    list.add(
        ItemBean.create(name: '我的帖子', assetName: ResName.documentText));
    list.add(
        ItemBean.create(name: '我的评论', assetName: ResName.messageNotif));
    list.add(ItemBean.create(name: '我的点赞', assetName: ResName.like));
    list.add(ItemBean.create(name: '我的收藏', assetName: ResName.star));
    return list;
  }

  List<ItemBean> buildLineItem() {
    var list = <ItemBean>[];
    list.add(ItemBean.create(name: '我的萌宠', assetName: ResName.ghost));
    list.add(
        ItemBean.create(name: '常见问腿', assetName: ResName.messageQuestion));
    list.add(ItemBean.create(name: '经期记录', assetName: ResName.container));
    return list;
  }

  onContentItemClicked(int index) {
    if (index == 0) {
      navigateTo(RouteName.cutePet);
    } else if (index == 1) {
      navigateTo(RouteName.faq);
    } else {
    //   showDateRangePicker(
    //       context: Get.context!, firstDate: DateTime.now().subtract(Duration(days: 365)),
    //     // 开始日期
    //     initialEntryMode: DatePickerEntryMode.calendarOnly,
    //
    // lastDate: DateTime.now(),);
      navigateTo(RouteName.periodRecord);
    }
  }

  onLineItemClicked(int index) {
    if (index == 0) {
      navigateTo(RouteName.postView);
    } else if (index == 1) {
      navigateTo(RouteName.review);
    } else if (index == 2) {
      navigateTo(RouteName.likeView);
    } else {
      navigateTo(RouteName.collectView);
    }
  }

  onEditInfoClicked() async {
    await Get.toNamed(RouteName.editInfo);
    update([avatorId]);
    update([nickNameId]);
  }

  onSettingClicked() {
    navigateTo(RouteName.setting);
  }
}

class ItemBean {
  final String assetName;
  final String name;

  ItemBean.create({required this.name, required this.assetName});
}
