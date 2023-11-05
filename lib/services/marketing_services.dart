import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/models/marketing_model.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class MarketingServices {
  static Future<List<MarketingModel>> getAll() async {
    try {
      List<MarketingModel> result = [];
      var response =
          await NetworkService.firestore.collection('marketing').get();

      response.docs.forEach((element) async {
        result.add(MarketingModel.fromJson(element.data()));
      });

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
