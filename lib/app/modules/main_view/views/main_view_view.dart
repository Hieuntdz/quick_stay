import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/modules/home/controllers/home_controller.dart';

import '../controllers/main_view_controller.dart';
import 'fab_bottom_bar.dart';
import 'outer_notched_shape.dart';

class MainViewView extends GetView<MainViewController> {

  void _onTapped(int index) {
    controller.changePage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: '',
        color: Color(0xff8F9BB3),
        backgroundColor: Colors.white,
        selectedColor: Colors.red,
        notchedShape: CircularOuterNotchedRectangle(),
        onTabSelected: _onTapped,
        items: [
          FABBottomAppBarItem(
              iconData: Image.asset("assets/images/ic_home.png"),
              text: 'Trang chủ'),
          FABBottomAppBarItem(
              iconData: Image.asset("assets/images/ic_order.png"),
              text: 'Đơn hàng'),
          FABBottomAppBarItem(
              iconData: Image.asset("assets/images/ic_promote.png"),
              text: 'Ưu đãi'),
          FABBottomAppBarItem(
              iconData: Image.asset("assets/images/ic_profile.png"),
              text: 'Tài khoản'),
        ],
      ),
      body: Obx(
        () {
          return controller.listPage[controller.currentPage];
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 25),
        child: SizedBox(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              HomeController homeController = Get.find();
              controller.showMapPage(homeController.position);
            },
            child: Container(
              height: 64,
              width: 64,
              child: Image.asset("assets/images/ic_map.png"),
            ),
          ),
        ),
      ),
    );
  }
}
