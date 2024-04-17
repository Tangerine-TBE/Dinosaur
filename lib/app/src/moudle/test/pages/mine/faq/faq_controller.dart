import 'package:app_base/exports.dart';

class FaqController extends BaseController{
  final list = <ItemBean>[];
  final listId = 1;
  @override
  onInit(){
    super.onInit();
    _fetchItemBeans();


  }
  
  _fetchItemBeans(){
    list.add(ItemBean(title: '蓝牙连接'));
    list.add(ItemBean(title: '充电清晰'));
    list.add(ItemBean(title: '正确使用'));
    list.add(ItemBean(title: '超时空遥控（远程遥控）'));
    list.add(ItemBean(title: '自己玩'));
    list.add(ItemBean(title: '下载更新'));
    list.add(ItemBean(title: '删除信息'));
    list.add(ItemBean(title: '审核禁言'));
    list.add(ItemBean(title: '玩转怪兽圈'));
    list.add(ItemBean(title: '健康训练'));
    update([listId]);
  }
}
class ItemBean{
  final String title;
  ItemBean({required this.title});
}