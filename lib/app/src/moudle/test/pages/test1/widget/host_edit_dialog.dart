import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_dialog_widget.dart';

class HostEditDialog extends StatefulWidget {
  final Function(String value, String target) onConfirm;
  final Function() onCancel;
  String host;
  String port;
  String target;

  HostEditDialog({super.key,
    required this.onConfirm,
    required this.onCancel,
    this.host = '',
    this.target = '',
    this.port = ''});

  @override
  State<HostEditDialog> createState() => _HostEditDialogState();
}

class _HostEditDialogState extends State<HostEditDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController hostController = TextEditingController(
        text: widget.host);
    TextEditingController portController = TextEditingController(
        text: widget.port);
    return BaseDialogWidget(
      title: 'Host Edit',
      titleStyle: TextStyle(color: Colors.black),
      info: Column(
        children: [
          Row(
            children: [
              Text('地址:', style: TextStyle(fontSize: 18),),
              Expanded(
                child: TextField(
                  controller: hostController,
                  enabled: true,
                  autofocus: false,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  style: TextStyle(
                    fontSize: 18.sp,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  onChanged: (value) => {widget.host = value},
                  decoration: InputDecoration(
                      hintText: 'Host Edit',
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
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),

          Row(
            children: [Text('端口:', style: TextStyle(fontSize: 18),), Expanded(
              child: TextField(
                controller: portController,
                enabled: true,
                autofocus: false,
                minLines: 1,
                textInputAction: TextInputAction.send,
                style: TextStyle(
                  fontSize: 18.sp,
                  textBaseline: TextBaseline.alphabetic,
                ),
                onChanged: (value) => {widget.port = value},
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: 'Port Edit',
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
            )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Text('目标:', style: TextStyle(fontSize: 18),),
              Expanded(
                child: TextField(
                  enabled: true,
                  autofocus: false,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  style: TextStyle(
                    fontSize: 18.sp,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  onChanged: (value) => {widget.target = value},
                  decoration: InputDecoration(
                      hintText: 'Host Edit',
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
              )
            ],
          ),

        ],
      ),
      leftButton: MaterialButton(
        onPressed: () {
          widget.onCancel.call();
        },
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Text(
          '取消',
          style: TextStyle(color: Colors.white),
        ),
      ),
      rightButton: MaterialButton(
        onPressed: () {
          if (widget.host.isEmpty) {
            showToast('host不能为空');
            return;
          }
          if (widget.port.isEmpty) {
            showToast('port不能为空');
            return;
          }
          widget.onConfirm.call(
              "${widget.host}/${widget.port}", widget.target);
        },
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Text(
          '确定',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
