import 'package:app_base/config/user.dart';
import 'package:app_base/exports.dart';
import 'package:app_base/mvvm/model/comment_bean.dart';
import 'package:app_base/mvvm/model/mine_bean.dart';
import 'package:app_base/mvvm/repository/mine_repo.dart';
import 'package:get/get.dart';

class MineReviewController extends BaseController {
  final postList = [1];
  final postListId = 1;
  final _repo = Get.find<MineRepo>();
  final list = <CommentList>[];
  final listId = 1;

  @override
  onInit() {
    _fetchPostList();
    super.onInit();
  }

  _fetchPostList() async {
    final response = await _repo.getMineCommentList(
      MineReq(
          userId: User.loginRspBean!.userId,
          pageSize: 10,
          pageIndex: 1,
          orderBy: 'createTime desc'),
    );
    if (response.isSuccess) {
      if (response.data?.data != null) {
        list.addAll(response.data!.data!.commentList);
        update([listId]);
      }
    }
  }
}
