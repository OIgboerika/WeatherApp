import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late Set<String> searchHistory;

typedef AnimationEndCallback = void Function();

animateMapMovement(MapController mapController, AnimationController mapAnimationController, LatLng start, LatLng end,
    [double? zoom, AnimationEndCallback? callback]) {
  LatLngTween tween = LatLngTween(begin: start, end: end);
  Tween<double> zoomTween = zoom != null ? Tween(begin: mapController.camera.zoom, end: zoom) : ConstantTween(mapController.camera.zoom);

  final Animation<double> animation = CurvedAnimation(
    parent: mapAnimationController,
    curve: Curves.fastOutSlowIn,
  );

  listener() {
    mapController.move(tween.evaluate(animation), zoomTween.evaluate(animation));
  }

  mapAnimationController.addListener(listener);
  mapAnimationController.forward().then((_) {
    if (callback != null) callback();
    mapAnimationController
      ..removeListener(listener)
      ..reset();
  });
}

showSnackBar(String message, BuildContext context, {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: CupertinoColors.destructiveRed,
      action: action,
      duration: action == null ? const Duration(seconds: 3) : const Duration(days: 1),
    ),
  );
}
