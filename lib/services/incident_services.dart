import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:sicef_hakaton/models/incident_model.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class IncidentServices {
  static Future<List<IncidentModel>> getAll() async {
    try {
      List<IncidentModel> result = [];
      var response =
          await NetworkService.firestore.collection('incidents').get();

      response.docs.forEach((element) async {
        result.add(IncidentModel.fromJson(element.data()));
      });

      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<IncidentModel> getSingle(String id) async {
    try {
      var response =
          await NetworkService.firestore.collection('incidents').doc(id).get();
      return IncidentModel.fromJson(response.data()!);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> create(IncidentModel incidentData) async {
    try {
      final response = await NetworkService.firestore
          .collection('incidents')
          .add(incidentData.toJson());
      await response.update({
        'id': response.id,
      });

      final locationResponses =
          await NetworkService.firestore.collection('locations').get();

      List<LocationModel> sendNotificationList = [];

      locationResponses.docs.forEach((element) {
        LocationModel location = LocationModel.fromJson(element.data());

        var distance = calculateDistance(
            incidentData.lat, incidentData.lng, location.lat, location.lng);

        if (distance < 750) sendNotificationList.add(location);
      });

      print(sendNotificationList);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> delete(String incidentId) async {
    try {
      await NetworkService.firestore
          .collection('incidents')
          .doc(incidentId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  static double radians(double degrees) {
    return degrees * (pi / 180.0);
  }

  static double calculateDistance(
      double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = radians(lat1);
    double lng1Rad = radians(lng1);
    double lat2Rad = radians(lat2);
    double lng2Rad = radians(lng2);

    // Haversine formula
    double dLat = lat2Rad - lat1Rad;
    double dLng = lng2Rad - lng1Rad;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLng / 2) * sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = earthRadius * c;

    return distance * 1000;
  }
}
