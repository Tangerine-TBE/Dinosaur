class Api {
  static const registerClient = '/api/v1/smart/user/regsiter';
  static const loginClient = '/api/v1/smart/user/login';
  static const logoutClient = '/api/v1/smart/user/logout';
  //话题中心列表请求与创建
  static const topCenterClient = '/api/v1/meng/topic/list';
  static const topCenterCreate = '/api/v1/meng/topic';
  //验证码请求
  static const sendAuthCode = '/api/v1/meng/user/mobile/sendAuthCode';
  //我的模式创建与获取
  static const sendRecord = '/api/v1/meng/mode';
  static const getModel = '/api/v1/meng/mode/list';

  //帖子获取与创建 （推荐，精选，动态，最新）
  static const getPushMsg = '/api/v1/meng/posts/list';
  static const pushMsg = '/api/v1/meng/posts';
  //波形获取与创建
  static const getCharts ='/api/v1/meng/wave/list';
  static const pushCharts = '/api/v1/meng/wave';
  //我的（帖子）
  static const minePost ='/api/v1/meng/my/posts/list';
  //我的（评论）
  static const mineReview ='/api/v1/meng/my/comment/list';
  //我的（点赞）
  static const mineLike = '/api/v1/meng/my/likes/list';
  //我的（收藏）
  static const mineCollect = '/api/v1/meng/my/favorite/list';
  //文件上传(getToken)
  static const upLoadFile = '/api/v1/third/aliyun/getOssAuth';
  //获取评论列表
  static const getCommentList = '/api/v1/meng/comment/list';
  //创建评论
  static const createComment = '/api/v1/meng/comment';
}
