import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NetworkService {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;
  static final messaging = FirebaseMessaging.instance;

  static Future<String> getAddress(double lan, double lng) async {
    String address = '';
    final response = await http.get(Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=${lan}&lon=${lng}&apiKey=5c96e4d9974c411090a745b71854f0fe'));

    if (response.statusCode == 200) {
      address =
          json.decode(response.body)['features'][0]['properties']['formatted'];
    } else {
      address = lan.toStringAsFixed(5) + ", " + lng.toStringAsFixed(5);
    }

    return address;
  }
}
