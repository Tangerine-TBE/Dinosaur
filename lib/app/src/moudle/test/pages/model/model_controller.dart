import 'package:app_base/exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModelController extends BaseController {
  late PageController pageController;
  final currentModelPage = 0.obs;
  final process = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    pageController.addListener(() {
      if(pageController.page! <= 0.1){
        currentModelPage.value = 0;
      }else if(pageController.page! >= 0.9){
        currentModelPage.value = 1;
      }
    });
  }
  changePage() {
    var currentPage = currentModelPage.value;
    pageController.animateToPage(
      currentPage == 0 ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

}
