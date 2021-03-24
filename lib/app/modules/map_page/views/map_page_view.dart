import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick_stay_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:quick_stay_flutter/app/modules/map_page/views/map_maker_painter.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:quick_stay_flutter/app/utils/logger.dart';

import '../controllers/map_page_controller.dart';

class MapPageView extends GetView<MapPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      bottom: true,
      top: true,
      child: Scaffold(
        body: _content(),
      ),
    );
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _add() {
    Marker marker = Marker(
        markerId: MarkerId("df"),
        position: LatLng(21.0021546, 105.8056378),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);

    markers[MarkerId("df")] = marker;
  }

  _content() {
    _add();

    Marker marker = Marker(
        markerId: MarkerId("df"),
        position: LatLng(37.42796133580664, -122.085749655962),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);

    return Stack(
      children: [
        _bounderry(),
        Obx(
          () {
            return GoogleMap(
              markers: Set<Marker>.of(controller.listMarker.value.toSet()),
              mapType: MapType.normal,
              initialCameraPosition: controller.cameraPosition,
              onMapCreated: (GoogleMapController mapController) {
                controller.mapController.complete(mapController);
              },
              zoomControlsEnabled: false,
            );
          },
        ),
        Container(
          width: double.infinity,
          height: 60,
          color: Colors.white10.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset("assets/images/ic_back.svg"),
              Text(
                "Các khách sạn được đề xuất",
                style: TextStyle(
                    color: Color(0xff36353E),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SvgPicture.asset("assets/images/ic_search.svg"),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _bottomView(),
        ),
      ],
    );
  }

  _bounderry() {
    return Obx(
      () => Stack(
        children: List.generate(
          controller.listMarkerKey.value.length,
          (index) => RepaintBoundary(
            key: controller.listMarkerKey.value[index],
            child: Container(
              width: 120,
              height: 80,
              alignment: Alignment.center,
              child: CustomPaint(
                painter: MapMarkerPainter(),
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "450",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bottomView() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _itemBottom("assets/images/ic_sort.svg", "Sắp xếp"),
                  SizedBox(
                    width: 8,
                  ),
                  _itemBottom("assets/images/ic_star_grey.svg", "Hạng sao"),
                  SizedBox(
                    width: 8,
                  ),
                  _itemBottom("assets/images/ic_price.svg", "Giá"),
                  SizedBox(
                    width: 8,
                  ),
                  _itemBottom("assets/images/ic_utils.svg", "Tiện nghi"),
                ],
              ),
            ),
            flex: 1,
          ),
          SizedBox(
            width: 20,
          ),
          SvgPicture.asset("assets/images/ic_floating.svg"),
          SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }

  _itemBottom(String icon, String text) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0xff8F9BB3).withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          Text(
            text,
            style: TextStyle(color: Color(0xff8F9BB3), fontSize: 11),
          ),
        ],
      ),
    );
  }
}
