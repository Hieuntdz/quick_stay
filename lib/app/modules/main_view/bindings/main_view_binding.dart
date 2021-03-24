import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:quick_stay_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:quick_stay_flutter/app/modules/map_page/controllers/map_page_controller.dart';
import 'package:quick_stay_flutter/app/modules/order_page/controllers/order_page_controller.dart';
import 'package:quick_stay_flutter/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:quick_stay_flutter/app/modules/promote_page/controllers/promote_page_controller.dart';

import '../controllers/main_view_controller.dart';

class MainViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainViewController>(
      () => MainViewController(),
    );
    Get.put(HomeController());
    Get.put(OrderPageController());
    Get.put(PromotePageController());
    Get.put(LoginController());
  }
}
