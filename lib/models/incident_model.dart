import 'package:sicef_hakaton/models/incident_type.dart';

class IncidentModel {
  final String id;
  final String title;
  final IncidentType type;
  final double lat;
  final double lng;
  final String description;
  final DateTime timestamp;
  final bool isActive;
  final int upVotes;

  IncidentModel({
    required this.id,
    required this.title,
    required this.type,
    required this.lat,
    required this.lng,
    required this.description,
    required this.timestamp,
    required this.isActive,
    this.upVotes = 0,
  });

  IncidentModel copyWith({
    String? id,
    String? title,
    IncidentType? type,
    double? lat,
    double? lng,
    String? description,
    DateTime? timestamp,
    bool? isActive,
    int? upVotes,
  }) {
    return IncidentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      isActive: isActive ?? this.isActive,
      upVotes: upVotes ?? this.upVotes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.id,
      'lat': lat,
      'lng': lng,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'isActive': isActive,
      'upVotes': upVotes,
    };
  }

  static IncidentModel fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      id: json['id'],
      title: json['title'],
      type: IncidentType.values
          .firstWhere((element) => element.id == json['type']),
      lat: json['lat'],
      lng: json['lng'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
      isActive: json['isActive'],
      upVotes: json['upVotes'],
    );
  }

  @override
  String toString() {
    return 'IncidentModel(id: $id, title: $title, type: $type, lat: $lat, lng: $lng, description: $description, timestamp: $timestamp, isActive: $isActive, upVotes: $upVotes)';
  }
}
