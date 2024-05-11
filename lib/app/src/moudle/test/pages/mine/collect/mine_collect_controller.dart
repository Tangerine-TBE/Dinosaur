import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/repository/mine_repo.dart';
import 'package:get/get.dart';

class MineCollectController extends BaseController {
  final postList = [1];
  final postListId = 1;
  final _repo = Get.find<MineRepo>();
  final list = <PostsList>[];
  final listId = 1;

  _fetchPostList() async {
    final response = await _repo.getCollect(
      MineReq(
        userId: User.loginRspBean!.userId,
        pageSize: 10,
        orderBy: 'createTime desc',
        pageIndex: 1,
      ),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        list.addAll(response.data!.data!.postsList);
        update([listId]);
      }
    }
  }

  @override
  void onInit() {
    _fetchPostList();
    super.onInit();
  }
}
