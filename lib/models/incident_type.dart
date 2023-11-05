// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum IncidentType {
  Traffic('Traffic', Icons.car_crash, 'traffic', 60),
  PublicSafety('Public safety', Icons.local_police, 'public-safety', 45),
  FireAndExplosion('Fire and explosions', Icons.local_fire_department,
      'fire-and-explosion', 45),
  Environmental('Environmental', Icons.public, 'environmental', 360),
  Other('Other', Icons.nearby_error, 'other', 30);

  const IncidentType(
    this.name, // Display name for type
    this.icon, // Icon for type
    this.id, // Internal name for type
    this.defaultIntervalMinutes, // Default deactivation time in minutes
  );

  final String id;
  final IconData icon;
  final String name;
  final int defaultIntervalMinutes;
}
