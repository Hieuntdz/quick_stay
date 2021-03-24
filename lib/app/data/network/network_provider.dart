import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:quick_stay_flutter/app/data/model/response/banner_data.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_category.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_data.dart';
import 'package:quick_stay_flutter/app/data/model/response/login_response.dart';
import 'package:quick_stay_flutter/app/utils/logger.dart';

import 'app_remote.dart';

class NetWorkProvider {
  Dio createDio(String domain) {
    BaseOptions options = new BaseOptions(
      baseUrl: '$domain',
      connectTimeout: AppRemote.connectionTimeout,
      receiveTimeout: AppRemote.receiveTimeout,
    );
    Dio dio = Dio(options);
    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    dio.interceptors.add(LogInterceptor(responseBody: false));
    return dio;
  }

  Dio _dio;

  NetWorkProvider() {
    _dio = createDio(AppRemote.baseUrl);
  }

  Future<LoginResponse> login(String phone, String passWord) async {
    Map<String, dynamic> params = Map();
    params[AppRemote.params.paramPhone] = phone;
    params[AppRemote.params.paramPassword] = passWord;
    params[AppRemote.params.paramTokenDevice] = "0a2bd63b2dda91df";
    params[AppRemote.params.paramTokenFirebase] =
        "cxG2vlX3MEA:APA91bEuOTjLh41LHDZap3zGD1AacWmoFIn-r0PxRbLV83SpVWjXPJiUraVWE6DYYgKE_WyP7v8IGimzOtIp0Q-1tvfXuiIxsbyC19kLr4Up9y0Agz9PDJ78ai_oT0p0WUTgBZktSKS";
    params[AppRemote.params.paramDeviceType] = 1;

    Response response =
        await _dio.post(AppRemote.login, queryParameters: params);
    Logger.debug("LoginResponse ${response.data}");
    LoginResponse loginResponse = LoginResponse.fromJson(response.data);
    return loginResponse;
  }

  Future<List<BannerData>> getListBanner() async {
    Response response = await _dio.get(AppRemote.banner);
    Logger.debug("BannerData ${response.data}");

    List<BannerData> listBanner = new List();

    if (response.data['data'] != null) {
      response.data['data'].forEach((v) {
        listBanner.add(new BannerData.fromJson(v));
      });
    }

    return listBanner;
  }

  Future<List<HotelCategory>> getListHotelCategory() async {
    Response response = await _dio.get(AppRemote.hotelCategory);
    Logger.debug("getListHotelCategory ${response.data}");

    List<HotelCategory> listCategory = [];

    if (response.data['data'] != null) {
      response.data['data'].forEach((v) {
        listCategory.add(new HotelCategory.fromJson(v));
      });
    }
    return listCategory;
  }

  Future<List<HotelData>> getListHighLightHotel(Position position) async {
    Map<String, double> params = HashMap();
    params[AppRemote.params.paramLat] = position.latitude;
    params[AppRemote.params.paramLng] = position.longitude;
    Response response =
        await _dio.get(AppRemote.hotelHighLight, queryParameters: params);

    if (response == null) return null;
    Logger.debug("getListHighLightHotel ${response.data}");

    List<HotelData> listHotel = [];

    if (response.data['success'] == 1 && response.data['data'] != null) {
      response.data['data'].forEach((v) {
        listHotel.add(new HotelData.fromJson(v));
      });
    }
    return listHotel;
  }

  Future<List<HotelData>> getListRecommendHotel(Position position) async {
    Map<String, double> params = HashMap();
    params[AppRemote.params.paramLat] = position.latitude;
    params[AppRemote.params.paramLng] = position.longitude;
    Response response =
        await _dio.get(AppRemote.listHomeHotel, queryParameters: params);

    if (response == null) return null;
    Logger.debug("getListHighLightHotel ${response.data}");

    List<HotelData> listHotel = [];

    if (response.data['success'] == 1 && response.data['data'] != null) {
      response.data['data'].forEach((v) {
        listHotel.add(new HotelData.fromJson(v));
      });
    }
    return listHotel;
  }

  Future<List<HotelData>> getListMapHotel(Position position) async {
    Map<String, dynamic> params = HashMap();
    params[AppRemote.params.paramLat] = position.latitude;
    params[AppRemote.params.paramLng] = position.longitude;
    params[AppRemote.params.paramIsMap] = 1;
    params[AppRemote.params.paramPage] = 1;
    Response response =
        await _dio.get(AppRemote.listHomeHotel, queryParameters: params);

    if (response == null) return null;
    Logger.debug("getListMapHotel ${response.data}");

    List<HotelData> listHotel = [];

    if (response.data['success'] == 1 && response.data['data'] != null) {
      response.data['data'].forEach((v) {
        listHotel.add(new HotelData.fromJson(v));
      });
    }
    return listHotel;
  }
}
