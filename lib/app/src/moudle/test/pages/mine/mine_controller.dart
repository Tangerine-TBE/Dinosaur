import 'package:app_base/exports.dart';

class MineController extends BaseController {
  List<ItemBean> buildTitleItem() {
    var list = <ItemBean>[];
    list.add(ItemBean.create(name: '我的帖子', assetName: ResName.documentText));
    list.add(ItemBean.create(name: '我的评论', assetName: ResName.messageNotif));
    list.add(ItemBean.create(name: '我的点赞', assetName: ResName.like));
    list.add(ItemBean.create(name: '我的收藏', assetName: ResName.star));
    return list;
  }

  List<ItemBean> buildLineItem() {
    var list = <ItemBean>[];
    list.add(ItemBean.create(name: '我的萌宠', assetName: ResName.ghost));
    list.add(ItemBean.create(name: '常见问腿', assetName: ResName.messageQuestion));
    list.add(ItemBean.create(name: '经期记录', assetName: ResName.container));
    return list;
  }

  onContentItemClicked(int index) {
    if (index == 0) {
      //Todo
    } else if (index == 1) {
      //Todo
    } else {
      //Todo
    }
    logE("onContentItemClicked $index");

  }
  onLineItemClicked(int index){
    if(index == 0){
    //Todo
    }else if(index == 1){
    //Todo
    }else if(index == 2 ){
    //Todo
    }else if (index == 3){
    //Todo
    }else {
    //Todo
    }
    logE("onLineItemClicked $index");

  }

}

class ItemBean {
  final String assetName;
  final String name;

  ItemBean.create({required this.name, required this.assetName});
}
