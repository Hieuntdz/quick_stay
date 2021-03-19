import 'package:geolocator/geolocator.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_data.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local.dart';
import 'model/response/banner_data.dart';
import 'model/response/hotel_category.dart';
import 'model/response/login_response.dart';
import 'network/network_provider.dart';

class Repository {
  static final Repository _repository = Repository._internal();

  NetWorkProvider _netWorkProvider = new NetWorkProvider();

  factory Repository() {
    return _repository;
  }

  Repository._internal();

  LocalStorage _localStorage;

  void setDarkMode(bool value) {
    _localStorage.setDarkMode(value);
  }

  bool getIsDarkMode() {
    return _localStorage.getIsDarkMode(AppPresKey.useDarkMode);
  }

  Future<LoginResponse> login(String phone, String passWord) {
    return _netWorkProvider.login(phone, passWord);
  }

  Future<List<BannerData>> getListBanner() {
    return _netWorkProvider.getListBanner();
  }

  Future<List<HotelCategory>> getListCategory() {
    return _netWorkProvider.getListHotelCategory();
  }

  Future<List<HotelData>> getListHighLightHotel(Position position) {
    return _netWorkProvider.getListHighLightHotel(position);
  }

  Future<List<HotelData>> getListRecommendHotel(Position position) {
    return _netWorkProvider.getListRecommendHotel(position);
  }
}
