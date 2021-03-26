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
import 'dart:ui' as ui;

class MapPageController extends GetxController {
  Repository _repository = Repository();

  Position position = Position();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 20,
  );
  Completer<GoogleMapController> mapController = Completer();

  RxList<HotelData> listHotel = <HotelData>[].obs;

  RxMap<MarkerId, Marker> listMarker = RxMap();

  var listMarkerKey = <GlobalKey>[].obs;

  Marker currentMarkerSelected;
  String oldPrice = "";

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

      // Uint8List markerIcon = await Helper.getUint8List(listMarkerKey[i]);

      Uint8List markerIcon =
          await getBytesFromCanvas(data.priceOn, Colors.white);

      Marker marker = Marker(
          markerId: id,
          position: LatLng(double.parse(data.lat), double.parse(data.lng)),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            _onMarkerTapped(id, data);
          });

      listMarker[id] = marker;
    }
  }

  Future<void> _onMarkerTapped(MarkerId markerId, HotelData data) async {
    Uint8List markerIconRed =
        await getBytesFromCanvas(data.priceOn, Colors.red);

    var marker = listMarker[markerId];

    Marker newMarker = Marker();
    newMarker = marker.copyWith(
      iconParam: BitmapDescriptor.fromBytes(markerIconRed),
    );

    listMarker[markerId] = newMarker;

    if (currentMarkerSelected != null) {
      Uint8List markerIconWhite =
          await getBytesFromCanvas(oldPrice, Colors.white);
      MarkerId tmpId = currentMarkerSelected.markerId;
      Marker tmpMarker = listMarker[tmpId];
      listMarker[tmpId] = tmpMarker.copyWith(
        iconParam: BitmapDescriptor.fromBytes(markerIconWhite),
      );
    }

    oldPrice = data.priceOn;
    currentMarkerSelected = newMarker;
  }

  Future<Uint8List> getBytesFromCanvas(String text, Color color) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    Size size = Size(120, 80);

    Paint paint = Paint()..color = color;
    Paint paint1 = Paint()
      ..color = Colors.grey.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final paint2 = Paint()
      ..color = color
      ..strokeWidth = 2;

    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height - 20, Radius.circular(8)),
        paint);

    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height - 20, Radius.circular(8)),
        paint1);

    Path path = Path();

    double startX = size.width / 2 - 15;
    double endX = size.width / 2 + 15;
    double startY = size.height - 20;
    double endY = size.height;

    path.moveTo(startX, startY);
    path.quadraticBezierTo(size.width / 2, endY, endX, startY);

    path.lineTo(startX, startY);

    canvas.drawPath(path, paint);

    canvas.drawPath(path, paint1);

    canvas.drawLine(Offset(startX, startY), Offset(endX, startY), paint2);

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: text, //you can write your own text here or take from parameter
      style: TextStyle(
          fontSize: size.width / 4,
          color: Colors.black,
          fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size.width / 2 - painter.width / 2,
          size.height / 2 - painter.height / 2 - 10),
    );

    final img = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }
}
