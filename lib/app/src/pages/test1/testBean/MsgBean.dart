class MsgBean {
  final String msg;
  final int type; //0接收 1发送
  MsgBean.create({required this.msg, required this.type});
}
