class AppRemote {
  AppRemote._();

  // base url
  static const String baseUrl = "https://test.quickstay.vn/api";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // login endpoints
  static const String login = "/customer/login";
  //banner
  static const String banner = "/list-banners";
  //category
  static const String hotelCategory = "/list-hotel-categories";

  static const String hotelHighLight = "/list-top-hotels/v2";

  static const String listHomeHotel = "/search/hotels/v5";

  static AppRemoteParams params = new AppRemoteParams();
}

class AppRemoteParams {
  String paramPhone = 'phone';
  String paramPassword = 'password';
  String paramTokenDevice = 'token_device';
  String paramTokenFirebase = 'token_firebase';
  String paramDeviceType = 'device_type';
  String paramLat = 'lat';
  String paramLng = 'lng';
  String paramIsMap = 'is_map';
  String paramPage = 'page';
}
