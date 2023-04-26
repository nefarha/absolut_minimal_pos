import 'package:get/get.dart';

import '../controllers/page_navigator_controller.dart';

class PageNavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageNavigatorController>(
      () => PageNavigatorController(),
    );
  }
}
