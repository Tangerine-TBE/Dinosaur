class Api {
  static const registerClient = '/api/v1/meng/user/regsiter';
  static const loginClientCode = '/api/v1/meng/user/login';
  static const loginClientPassword = '/api/v1/meng/user/login';
  static const logoutClient = '/api/v1/meng/user/logout';
  static const forgotPassword = '/api/v1/meng/user/forgot';
  //话题中心列表请求与创建
  static const topCenterClient = '/api/v1/meng/topic/list';
  static const topCenterCreate = '/api/v1/meng/topic';
  //手机验证码请求
  static const sendAuthCodePhone = '/api/v1/meng/user/mobile/sendAuthCode';
  //邮箱验证码请求
  static const sendAuthCodeEmail ='/api/v1/meng/user/mail/sendAuthCode';
  //我的模式创建与获取
  static const sendRecord = '/api/v1/meng/mode';
  static const getModel = '/api/v1/meng/mode/list';

  //帖子获取与创建 （推荐，精选，动态，最新）
  static const getPushMsg = '/api/v1/meng/posts/list';
  //喜欢帖子
  static const likePush= '/api/v1/meng/posts/like';
  //收藏帖子
  static const collectPush ='/api/v1/meng/posts/favorite';
  //帖子推送
  static const pushMsg = '/api/v1/meng/posts';
  //波形获取与创建
  static const getCharts ='/api/v1/meng/wave/list';
  //收藏波形
  static const collectCharts ='/api/v1/meng/wave/favorite';
  //点赞波形
  static const likeCharts ='/api/v1/meng/wave/like';
  //推送帖子
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
  //点赞评论
  static const likeComment = '/api/v1/meng/posts/like';
  //收藏评论
  static const collectComment = '/api/v1/meng/posts/favorite';
  //登出
  static const logOut = '/api/v1/meng/user/logout';
  //获取登录用户信息
  static const getUserInfo = '/api/v1/meng/user';
  //保存我的经期
  static const savePeriodRecord = '/api/v1/meng/my/menstrual/save';
  //获取我的经期1
  static const getPeriodRecord ='/api/v1/meng/my/menstrual/query/history';
  //获取我的经期2
  static const getPeriodRecord1 = '/api/v1/meng/my/menstrual/query';
  //修改个人信息
  static const editUserInf0 = '/api/v1/meng/user';
  //获取我的配置
  static const getSettingInfo = '/api/v1/meng/my/setting/query';
  //保存我的配置
  static const saveSettingInfo = '/api/v1/meng/my/setting/save';
  //查询单条帖子
  static const querySingleOnePost = '/api/v1/meng/posts';
}
