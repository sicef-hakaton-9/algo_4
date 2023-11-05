import 'package:sicef_hakaton/models/location_model.dart';

class MarketingModel {
  final String? title;
  final double lat;
  final double lng;
  final String? url;

  MarketingModel({this.title, required this.lat, required this.lng, this.url});

  MarketingModel copyWith({
    String? title,
    double? lat,
    double? lng,
    String? url,
  }) {
    return MarketingModel(
      title: title ?? this.title,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      url: url ?? this.url,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'lat': lat,
      'lng': lng,
      'url': url,
    };
  }

  factory MarketingModel.fromJson(Map<String, dynamic> json) {
    return MarketingModel(
        title: json['title'],
        lat: json['lat'],
        lng: json['lng'],
        url: json['url']);
  }
}
