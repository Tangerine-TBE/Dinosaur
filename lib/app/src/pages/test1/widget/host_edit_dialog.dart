import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_dialog_widget.dart';

class HostEditDialog extends StatelessWidget {
  final Function(String value) onConfirm;
  final Function() onCancel;
  String host;
  String port;
   HostEditDialog({super.key,required this.onConfirm,required this.onCancel,this.host='',this.port=''});

  @override
  Widget build(BuildContext context) {

    TextEditingController hostController = TextEditingController(text: host);
    TextEditingController portController = TextEditingController(text: host);
    return BaseDialogWidget(
      title: 'Host Edit',
      titleStyle: TextStyle(color: Colors.black),
      info: Column(
        children: [
          TextField(
            controller: hostController,
            enabled: true,
            autofocus: false,
            minLines: 1,
            textInputAction: TextInputAction.send,
            style: TextStyle(
              fontSize: 18.sp,
              textBaseline: TextBaseline.alphabetic,
            ),
            onChanged: (value) => {
              host = value
            },
            decoration: InputDecoration(
                hintText:'Host Edit',
                contentPadding: const EdgeInsets.only(left: 10),
                alignLabelWithHint: true,
                hintStyle: const TextStyle(
                  height: 2.0,
                ),
                enabledBorder: OutlineInputBorder(
                  /*边角*/
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.black, //边线颜色为白色
                    width: 1, //边线宽度为2
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue, //边框颜色为白色
                    width: 1, //宽度为5
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black, //边框颜色为白色
                    width: 1, //宽度为5
                  ),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(height: 20.h,),
          TextField(
            controller:portController,
            enabled: true,
            autofocus: false,
            minLines: 1,
            textInputAction: TextInputAction.send,
            style: TextStyle(
              fontSize: 18.sp,
              textBaseline: TextBaseline.alphabetic,
            ),
            onChanged: (value) => {
              port = value
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10),
                hintText:'Port Edit',
                // suffixText: '发送',
                // suffixIcon: Icon(Icons.send),
                alignLabelWithHint: true,
                hintStyle: const TextStyle(
                  height: 2.0,
                ),
                enabledBorder: OutlineInputBorder(
                  /*边角*/
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.black, //边线颜色为白色
                    width: 1, //边线宽度为2
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue, //边框颜色为白色
                    width: 1, //宽度为5
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black, //边框颜色为白色
                    width: 1, //宽度为5
                  ),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
        ],
      ),
      leftButton: MaterialButton(
        onPressed: () {
          onCancel.call();
        },
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
        child: const Text('取消',style: TextStyle(color: Colors.white),),
      ),
      rightButton: MaterialButton(
        onPressed: () {
          if(host.isEmpty){
            showToast('host不能为空');
            return;
          }
          if(port.isEmpty){
            showToast('port不能为空');
            return;
          }
          onConfirm.call("$host/$port");
        },
        color: Colors.blueAccent,

        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
        child: const Text('确定',style: TextStyle(color: Colors.white),),

      ),
    );
  }
}
