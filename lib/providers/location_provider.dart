import 'package:flutter/material.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/services/location_services.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class Locations extends ChangeNotifier {
  List<LocationModel> _locations = [];

  get locations {
    return _locations;
  }

  Future<void> fetch() async {
    try {
      _locations =
          await LocationServices.getAll(NetworkService.auth.currentUser!.uid);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> create(LocationModel locationData) async {
    try {
      await LocationServices.create(locationData);
      _locations.add(locationData);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remove(String locId) async {
    try {
      await LocationServices.delete(locId);
      _locations.removeWhere((e) => e.id == locId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
