import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';

class Helper {
  static Future<bool> checkGpsEnable() async {
    var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    return isGpsEnabled;
  }

  static Widget loadImage(String url, {BoxFit fit}) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      imageUrl: url,
      errorWidget: (context, url, error) => Container(
        color: Colors.black38,
        alignment: Alignment.center,
      ),
    );
  }

  static Future<Uint8List> getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary =
    markerKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}
