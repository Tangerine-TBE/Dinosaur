import 'package:app_base/res/my_colors.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    Key? key,
    required this.title,
    this.margin = const EdgeInsets.symmetric(horizontal: 16),
    this.titleColor = Colors.white,
    this.backgroundColor = MyColors.textBlackColor,
    this.titleFontSize = 16,
    this.buttonHeight = 50,
    this.cornerRadius = 10,
    this.onPressed,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
  }) : super(key: key);
  final EdgeInsets margin;
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final double titleFontSize;
  final double buttonHeight;
  final double cornerRadius;
  final VoidCallback? onPressed;
  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: titleColor,
          minimumSize: Size.fromHeight(buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          side: BorderSide(
            width: borderWidth,
            color: borderColor,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            color: titleColor,
          ),
        ),
      ),
    );
  }
}
