import 'package:get/get.dart';

import '../controllers/promote_page_controller.dart';

class PromotePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromotePageController>(
      () => PromotePageController(),
    );
  }
}
