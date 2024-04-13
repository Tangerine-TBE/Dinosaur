import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateCustomModelDialog extends StatelessWidget{
  final Function onCancelCallBack;
  final Function(String value) onConfirmCallBack;
  String editContent = '';

   CreateCustomModelDialog({super.key,required this.onCancelCallBack,required this.onConfirmCallBack});
  @override
  Widget build(BuildContext context) {
    return  SimpleDialog(
      contentPadding: EdgeInsets.zero,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.only(top: 16,right: 20,left: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('创建模式'),
              ),
              SizedBox(height: 8),
              TextField(
                enabled: true,
                autofocus: false,
                minLines: 1,

                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  textBaseline: TextBaseline.alphabetic,
                ),
                onChanged: (value) => {editContent = value},
                decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: '模式名称',
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    alignLabelWithHint: true,
                    hintStyle:  TextStyle(
                      height: 2.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      /*边角*/
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.transparent, //边线颜色为白色
                        width: 1, //边线宽度为2
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent, //边框颜色为白色
                        width: 1, //宽度为5
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent, //边框颜色为白色
                        width: 1, //宽度为5
                      ),
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                        onPressed: () {
                          onCancelCallBack.call();
                          Get.back();
                        },
                        child: Text(
                          '取消',
                          style: TextStyle(
                              color: MyColors.textBlackColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                  Expanded(
                      child: TextButton(
                        onPressed: () {
                          onConfirmCallBack.call(editContent);
                          Get.back();
                        },
                        child: Text('确认',
                            style: TextStyle(
                                color: Colors.pink, fontWeight: FontWeight.w400)),
                      )),
                ],
              ),
            ],
          ),
        )
      ],
    );

  }

}