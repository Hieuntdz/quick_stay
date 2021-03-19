import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
}
