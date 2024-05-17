import 'package:app_base/exports.dart';

class FaqPageSecondController extends BaseController {
  final Map<String, String> content;
  final String title;

  FaqPageSecondController({
    required this.title,
    required this.content,
  });

  @override
  void onReady() {
    super.onReady();
  }

  onItemClicked(Map<String, String> map) {
    navigateTo(RouteName.faqSecondContent, args: map);
  }
}
