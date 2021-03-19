import 'package:get/get.dart';

import 'package:quick_stay_flutter/app/modules/home/bindings/home_binding.dart';
import 'package:quick_stay_flutter/app/modules/home/views/home_page_view.dart';
import 'package:quick_stay_flutter/app/modules/login/bindings/login_binding.dart';
import 'package:quick_stay_flutter/app/modules/login/views/login_view.dart';
import 'package:quick_stay_flutter/app/modules/main_view/bindings/main_view_binding.dart';
import 'package:quick_stay_flutter/app/modules/main_view/views/main_view_view.dart';
import 'package:quick_stay_flutter/app/modules/map_page/bindings/map_page_binding.dart';
import 'package:quick_stay_flutter/app/modules/map_page/views/map_page_view.dart';
import 'package:quick_stay_flutter/app/modules/order_page/bindings/order_page_binding.dart';
import 'package:quick_stay_flutter/app/modules/order_page/views/order_page_view.dart';
import 'package:quick_stay_flutter/app/modules/profile_page/bindings/profile_page_binding.dart';
import 'package:quick_stay_flutter/app/modules/profile_page/views/profile_page_view.dart';
import 'package:quick_stay_flutter/app/modules/promote_page/bindings/promote_page_binding.dart';
import 'package:quick_stay_flutter/app/modules/promote_page/views/promote_page_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.MAIN_VIEW;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePageView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_VIEW,
      page: () => MainViewView(),
      binding: MainViewBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_PAGE,
      page: () => OrderPageView(),
      binding: OrderPageBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PAGE,
      page: () => MapPageView(),
      binding: MapPageBinding(),
    ),
    GetPage(
      name: _Paths.PROMOTE_PAGE,
      page: () => PromotePageView(),
      binding: PromotePageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
  ];
}
