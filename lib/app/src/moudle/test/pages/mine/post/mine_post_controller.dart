import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/model/push_bean.dart';
import 'package:app_base/mvvm/repository/mine_repo.dart';
import 'package:get/get.dart';

class MinePostController extends BaseController {
  final postList = [1];
  final postListId = 1;
  final _repo = Get.find<MineRepo>();
  final list = <PostsList>[];
  final listId = 1;

  @override
  onInit() {
    _fetchPostList();
    super.onInit();
  }

  _fetchPostList() async {
    final response = await _repo.getCollect(MineReq(
      topicId: '124',
      pageSize: 10,
      topicType: 'Dynamic',
      orderBy: 'createTime desc',
      pageIndex: 1,
    ));
    if (response.isSuccess) {
      if (response.data?.data != null) {
        list.addAll(response.data!.data!.postsList);
        update([listId]);
      }
    }
  }
}
