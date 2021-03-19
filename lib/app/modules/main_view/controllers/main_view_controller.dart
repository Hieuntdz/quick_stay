import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/modules/home/views/home_page_view.dart';
import 'package:quick_stay_flutter/app/modules/map_page/views/map_page_view.dart';
import 'package:quick_stay_flutter/app/modules/order_page/views/order_page_view.dart';
import 'package:quick_stay_flutter/app/modules/profile_page/views/profile_page_view.dart';
import 'package:quick_stay_flutter/app/modules/promote_page/views/promote_page_view.dart';

class MainViewController extends GetxController {
  //TODO: Implement MainViewController

  final count = 0.obs;

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
    MapPageView(),
    PromotePageView(),
    ProfilePageView()
  ];

  int centerPage = 2;

  get listPage => _listPage;

  RxInt _currentPage = 0.obs;

  get currentPage => _currentPage.value;

  showMapPage() {
    this._currentPage.value = centerPage;
  }


  void changePage(int index) {
    if (index < centerPage) {
      this._currentPage.value = index;
    } else {
      this._currentPage.value = index + 1;
    }
  }
}
