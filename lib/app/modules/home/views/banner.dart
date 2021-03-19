import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/data/model/response/banner_data.dart';
import 'package:quick_stay_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:quick_stay_flutter/app/utils/helper.dart';

class BannerView extends StatelessWidget {
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: <Widget>[
            PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller.pageController,
              onPageChanged: _controller.onBannerPageViewChange,
              itemCount: _controller.listBanner.length,
              itemBuilder: (BuildContext context, int index) {
                BannerData banner = _controller.listBanner[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Helper.loadImage(banner.image, fit: BoxFit.fill),
                );
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                padding: const EdgeInsets.all(12.0),
                child: new Center(
                  child: DotsIndicator(
                    pageController: _controller.pageController,
                    itemCount: _controller.listBanner.length,
                    onPageSelected: (int page) {
                      _controller.onBannerPageViewChange(page);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.pageController,
    this.itemCount,
    this.onPageSelected,
    this.unSelectedColor: Colors.white,
    this.selectedColor: Colors.red,
  }) : super(listenable: pageController);

  final PageController pageController;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color unSelectedColor;
  final Color selectedColor;
  final HomeController controller = Get.find();

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    return Container(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: index == controller.currentBannerIndex
              ? selectedColor
              : unSelectedColor,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize,
            height: _kDotSize,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
