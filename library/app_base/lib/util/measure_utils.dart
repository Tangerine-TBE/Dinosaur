import 'package:flutter/material.dart';

double getBottomBarHeight(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  return mediaQuery.padding.bottom;
}