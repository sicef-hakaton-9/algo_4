import 'package:flutter/material.dart';
import 'package:sicef_hakaton/models/incident_model.dart';
import 'package:sicef_hakaton/services/incident_services.dart';

class Incidents extends ChangeNotifier {
  List<IncidentModel> _incidents = [];

  get incidents {
    return _incidents;
  }

  Future<void> fetchIncidents() async {
    try {
      _incidents = await IncidentServices.getAll();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reportIncident(IncidentModel incidentdata) async {
    try {
      await IncidentServices.create(incidentdata);
      _incidents.add(incidentdata);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
