class MsgBean {
  final String msg;
  final int type; //0接收 1发送
  final int size;
  MsgBean.create({required this.msg, required this.type,required this.size}){
     size+1;
  }
}
