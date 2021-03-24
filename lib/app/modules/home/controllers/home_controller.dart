import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_stay_flutter/app/data/model/response/banner_data.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_category.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_data.dart';
import 'package:quick_stay_flutter/app/data/repository.dart';
import 'package:quick_stay_flutter/app/utils/logger.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getListBanner();
    getListCategory();
    _determinePosition();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
  }

  Repository _repository = Repository();

  get currentBannerIndex => _currentBannerIndex;

  RxList _listBanner = <BannerData>[].obs;

  List<BannerData> get listBanner => _listBanner.value;

  RxList _listCategory = <HotelCategory>[].obs;

  List<HotelCategory> get listCategory => _listCategory.value;

  RxList _listHighLightHotel = <HotelData>[].obs;

  List<HotelData> get listHighLightHotel => _listHighLightHotel.value;

  RxList _listRecommendHotel = <HotelData>[].obs;

  List<HotelData> get listRecommendHotel => _listRecommendHotel.value;

  Position position;

  /*
    *handle scroll banner
   */
  PageController pageController = new PageController();
  RxInt _currentBannerIndex = 0.obs;
  Timer _timer;
  int delayNextBanner = 5;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  onBannerPageViewChange(int page) {
    resetTimerBanner();
    setCurrentPage(page);
  }

  void resetTimerBanner() {
    if (_timer == null) {
      return;
    }
    _timer.cancel();
    _timer =
        Timer.periodic(Duration(seconds: delayNextBanner), timerBannerCallback);
  }

  void setCurrentPage(int index) {
    this._currentBannerIndex.value = index;
  }

  void timerBannerCallback(Timer timer) {
    nextBanner();
    if (currentBannerIndex.value != 0 && pageController.hasClients) {
      pageController.animateToPage(
        currentBannerIndex.value,
        duration: _kDuration,
        curve: _kCurve,
      );
    } else {
      if (pageController.hasClients) {
        pageController.jumpToPage(currentBannerIndex.value);
      }
    }
  }

  void nextBanner() {
    if (currentBannerIndex.value >= listBanner.length - 1) {
      currentBannerIndex.value = 0;
    } else {
      currentBannerIndex.value++;
    }
  }

  void updateListBanner(List<BannerData> data) {
    _listBanner.clear();
    _listBanner.addAll(data);
  }

  void updateListCategory(List<HotelCategory> data) {
    _listCategory.clear();
    _listCategory.addAll(data);
  }

  Future<void> getListBanner() async {
    Logger.debug("start");
    List<BannerData> listData = await _repository.getListBanner();

    _listBanner.clear();
    _listBanner.addAll(listData);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer =
        Timer.periodic(Duration(seconds: delayNextBanner), timerBannerCallback);
  }

  Future<void> getListCategory() async {
    Logger.debug("start");
    List<HotelCategory> listData = await _repository.getListCategory();
    updateListCategory(listData);
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
    } else if (status.isGranted) {}
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Logger.debug("Location services are disabled.");
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        Logger.debug(
            "Location permissions are permanently denied, we cannot request permissions.");
      }

      if (permission == LocationPermission.denied) {
        Logger.debug("Location permissions are denied");
      }
    }

    position = await Geolocator.getCurrentPosition();
    getListHighLightHotel(position);
    getListRecommendHotel(position);
    Logger.debug("_determinePosition $position");
  }

  Future<void> getListHighLightHotel(Position position) async {
    Logger.debug("start");
    List<HotelData> listData =
        await _repository.getListHighLightHotel(position);
    _listHighLightHotel.clear();
    _listHighLightHotel.addAll(listData);
  }

  Future<void> getListRecommendHotel(Position position) async {
    Logger.debug("start");
    List<HotelData> listData =
    await _repository.getListHighLightHotel(position);
    _listRecommendHotel.clear();
    _listRecommendHotel.addAll(listData);
  }
}
