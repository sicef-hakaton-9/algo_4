import 'package:flutter/material.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/models/marketing_model.dart';
import 'package:sicef_hakaton/services/location_services.dart';
import 'package:sicef_hakaton/services/marketing_services.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class Marketing extends ChangeNotifier {
  List<MarketingModel> _locations = [];

  get locations {
    return _locations;
  }

  Future<void> fetch() async {
    try {
      _locations = await MarketingServices.getAll();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
