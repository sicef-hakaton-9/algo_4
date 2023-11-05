class LocationModel {
  final String id;
  final String title;
  final double lat;
  final double lng;
  final String userId;
  final String fcmToken;

  LocationModel({
    required this.id,
    required this.title,
    required this.lat,
    required this.lng,
    required this.userId,
    required this.fcmToken,
  });

  LocationModel copyWith({
    String? id,
    String? title,
    double? lat,
    double? lng,
    String? userId,
    String? fcmToken,
  }) {
    return LocationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        userId: userId ?? this.userId,
        fcmToken: fcmToken ?? this.fcmToken);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lat': lat,
      'lng': lng,
      'userId': userId,
      'fcmToken': fcmToken,
    };
  }

  static LocationModel fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      title: json['title'],
      lat: json['lat'],
      lng: json['lng'],
      userId: json['userId'],
      fcmToken: json['fcmToken'],
    );
  }

  @override
  String toString() {
    return 'IncidentModel(id: $id, title: $title, lat: $lat, lng: $lng, userId: $userId, fcmToken: $fcmToken)';
  }
}
