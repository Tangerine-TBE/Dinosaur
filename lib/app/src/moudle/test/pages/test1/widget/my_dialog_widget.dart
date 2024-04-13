import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BaseDialogWidget extends StatelessWidget {
  const BaseDialogWidget({
    required this.title,
    this.titleStyle,
    this.info,
    this.leftButton,
    this.rightButton,
    Key? key,
  }) : super(key: key);
  final String title;
  final TextStyle? titleStyle;
  final Widget? info;
  final Widget? leftButton;
  final Widget? rightButton;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding:  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration:  const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style:  const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ) ??
                    titleStyle,
              ),
               const SizedBox(height: 8),
              info ?? const SizedBox(),
               const SizedBox(height: 8),
              Row(
                children: [
                  leftButton != null
                      ? Expanded(
                          child: leftButton ?? const SizedBox(),
                        )
                      : const SizedBox(),
                   SizedBox(width: 8),
                  rightButton != null
                      ? Expanded(
                          child: rightButton ?? const SizedBox(),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
