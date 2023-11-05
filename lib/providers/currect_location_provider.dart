import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class CurrentLocation extends ChangeNotifier {
  LatLng _location = LatLng(43.3209, 21.8958);

  get location {
    return _location;
  }

  // Future<LocationData?> _currentLocation() async {
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;

  //   Location location = new Location();

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return null;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }
  //   return await location.getLocation();
  // }

  // Future<void> geoLocate() async {
  //   try {
  //     _location = await _currentLocation().then((value) =>
  //         LatLng(value?.latitude ?? 43.3209, value?.longitude ?? 21.8958));
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
