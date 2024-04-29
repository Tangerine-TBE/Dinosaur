import 'package:app_base/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyCheckboxWidget extends StatefulWidget {
   PrivacyCheckboxWidget({
    required this.onChanged,
    required this.onTapPrivacy,
    this.checked = false,
    required this.onTapAgreement,
    super.key,
  });
  final Function(bool) onChanged;
  final Function() onTapPrivacy;
  final Function() onTapAgreement;
   bool checked;

  @override
  State<PrivacyCheckboxWidget> createState() => _PrivacyCheckboxWidgetState();
}

class _PrivacyCheckboxWidgetState extends State<PrivacyCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            fillColor: MaterialStateProperty.all(MyColors.pageBgColor),
            side: BorderSide(color:MyColors.themeTextColor),
            checkColor: MyColors.bgLinearShapeColor1,
            value: widget.checked,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  widget.checked = value;
                });
                widget.onChanged(value);
              }
            },
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: RichText(

            overflow: TextOverflow.clip,
            text: _getTappableTextSpan('已阅读并同意', onTap: () {
              setState(() {
                widget.checked = !widget.checked;
                widget.onChanged(widget.checked);
              });
            }, children: [
              _getTappableTextSpan(
                '《小萌宠用户协议》',
                textColor: MyColors.themeTextColor,
                onTap: widget.onTapAgreement,
              ),
              _getTappableTextSpan('、',
              ),
              _getTappableTextSpan('《小萌宠隐私协议》',
                textColor: MyColors.themeTextColor,
                onTap: widget.onTapPrivacy,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  TextSpan _getTappableTextSpan(
    String text, {
    double fontSize = 16,
    Color textColor = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    VoidCallback? onTap,
    List<InlineSpan>? children,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
      children: children,
    );
  }
}
