import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class LocationServices {
  static Future<List<LocationModel>> getAll(String userId) async {
    try {
      List<LocationModel> result = [];
      var response =
          await NetworkService.firestore.collection('locations').get();

      response.docs.forEach((element) async {
        LocationModel tmp = LocationModel.fromJson(element.data());

        if (tmp.userId == userId) result.add(tmp);
      });

      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<LocationModel> getSingle(String locationId) async {
    try {
      var response = await NetworkService.firestore
          .collection('locations')
          .doc(locationId)
          .get();
      return LocationModel.fromJson(response.data()!);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> delete(String locationId) async {
    try {
      await NetworkService.firestore
          .collection('locations')
          .doc(locationId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> create(LocationModel locationData) async {
    try {
      final response = await NetworkService.firestore
          .collection('locations')
          .add(locationData.toJson());
      await response.update({
        'id': response.id,
      });
    } catch (e) {
      rethrow;
    }
  }
}
