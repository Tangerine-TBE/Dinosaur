import 'package:get/get.dart';
import 'package:common/base/mvvm/view/base_appbar_page.dart';
import 'package:flutter/material.dart';

abstract class BasePage<C> extends BaseAppBarPage<C> {
  const BasePage({super.key});

  @override
  Color get background => Colors.grey.withAlpha(20);

  @override
  Color get appbarBackgroundColor => Colors.white;

  @override
  double? get appBarElevation => 0;

  @override
  Color? get statusBarColor => Colors.white;

  @override
  Color get appBarTitleColor => Colors.yellow;

  @override
  Widget? buildLeftIcon() => const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.amber,
      );

  @override
  Widget? buildRightIcon() => null;

  @override
  void offNavigateTo(String route, {dynamic args}) {
    Get.offNamed(route, arguments: args);
  }

  void offAllNavigateTo(String rout, {dynamic args}) {
    Get.offAllNamed(rout, arguments: args);
  }
  void offAllUntilName(String rout,{dynamic args}){
    Get.offNamedUntil(rout, (route) => false,arguments: args);
  }
}
