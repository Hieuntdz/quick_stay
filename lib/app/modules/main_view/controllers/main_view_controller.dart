import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/modules/home/views/home_page_view.dart';
import 'package:quick_stay_flutter/app/modules/login/views/login_view.dart';
import 'package:quick_stay_flutter/app/modules/map_page/views/map_page_view.dart';
import 'package:quick_stay_flutter/app/modules/order_page/views/order_page_view.dart';
import 'package:quick_stay_flutter/app/modules/profile_page/views/profile_page_view.dart';
import 'package:quick_stay_flutter/app/modules/promote_page/views/promote_page_view.dart';
import 'package:quick_stay_flutter/app/routes/app_pages.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';

class MainViewController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  List<Widget> _listPage = [
    HomePageView(),
    OrderPageView(),
    PromotePageView(),
  ];

  int centerPage = 2;

  get listPage => _listPage;

  RxInt _currentPage = 0.obs;

  get currentPage => _currentPage.value;

  showMapPage(Position position) {
    Map<String, double> arg = HashMap();
    arg[AppBundleKey.keyLat] = position.latitude;
    arg[AppBundleKey.keyLng] = position.longitude;
    Get.toNamed(Routes.MAP_PAGE, arguments: arg);
  }

  void changePage(int index) {
    this._currentPage.value = index;
  }
}
