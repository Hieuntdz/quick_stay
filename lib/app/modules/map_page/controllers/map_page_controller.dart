import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick_stay_flutter/app/data/model/map_marker.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_data.dart';
import 'package:quick_stay_flutter/app/data/repository.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:quick_stay_flutter/app/utils/helper.dart';
import 'package:quick_stay_flutter/app/utils/logger.dart';

class MapPageController extends GetxController {
  Repository _repository = Repository();

  Position position = Position();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 20,
  );
  Completer<GoogleMapController> mapController = Completer();

  RxList<HotelData> listHotel = <HotelData>[].obs;

  var listMarker = <Marker>[].obs;

  var listMarkerKey = <GlobalKey>[].obs;

  @override
  void onInit() {
    super.onInit();
    Logger.debug("start");

    for (int i = 0; i <= 1000; i++) {
      listMarkerKey.add(new GlobalKey());
    }
  }

  @override
  void onReady() {
    super.onReady();
    Logger.debug("MapPageController onReady");
    var arg = Get.arguments;
    if (arg != null) {
      position = Position(
          latitude: arg[AppBundleKey.keyLat],
          longitude: arg[AppBundleKey.keyLng]);

      Logger.debug("MapPageController position $position");

      _goToThePosition(position);
      getListMapHotel(position);
    }
  }

  @override
  void onClose() {}

  Future<void> _goToThePosition(Position position) async {
    final GoogleMapController controller = await mapController.future;
    cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> getListMapHotel(Position position) async {
    Logger.debug("start");
    List<HotelData> listData = await _repository.getListMapHotel(position);
    listHotel.clear();
    listHotel.addAll(listData);
    Logger.debug("getListMapHotel size ${listHotel.length}");

    for (int i = 0; i < listData.length; i++) {
      HotelData data = listData[i];
      var id = MarkerId("${data.id}");

      // var markerKey = GlobalKey();
      // RepaintBoundary boundary = await createMapMarker(markerKey);
      // Uint8List markerIcon = await Helper.getUint8List(boundary.key);

      Uint8List markerIcon = await Helper.getUint8List(listMarkerKey[i]);

      Marker marker = Marker(
          markerId: id,
          position: LatLng(double.parse(data.lat), double.parse(data.lng)),
          onTap: () {
            _onMarkerTapped(id);
          },
          icon: BitmapDescriptor.fromBytes(markerIcon));
      // marker. = await getClusterMarker(data.price, Colors.red, Colors.black, 80);
      listMarker.add(marker);
    }
  }

  void _onMarkerTapped(MarkerId markerId) {}

  Future<RepaintBoundary> createMapMarker(GlobalKey mKey) async {
    return RepaintBoundary(
      key: mKey,
      child: Container(
        width: 20,
        height: 10,
        color: Colors.yellow,
      ),
    );
  }
}
