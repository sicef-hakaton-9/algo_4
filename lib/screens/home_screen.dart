import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sicef_hakaton/models/incident_model.dart';
import 'package:sicef_hakaton/models/incident_type.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/models/marketing_model.dart';
import 'package:sicef_hakaton/providers/currect_location_provider.dart';
import 'package:sicef_hakaton/providers/incident_provider.dart';
import 'package:sicef_hakaton/providers/location_provider.dart';
import 'package:sicef_hakaton/providers/marketing_provider.dart';
import 'package:sicef_hakaton/screens/new_incident_screen.dart';
import 'package:sicef_hakaton/screens/user_profile_screen.dart';
import 'package:sicef_hakaton/services/incident_services.dart';
import 'package:sicef_hakaton/widgets/location_widget.dart';
import 'package:sicef_hakaton/widgets/marketing_widget.dart';
import 'package:sicef_hakaton/widgets/prijava_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IncidentModel> incidentData = [];
  List<LocationModel> locationData = [];
  List<MarketingModel> marketingData = [];

  @override
  void initState() {
    Provider.of<Incidents>(context, listen: false).fetchIncidents();
    Provider.of<Locations>(context, listen: false).fetch();
    Provider.of<Marketing>(context, listen: false).fetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    incidentData = Provider.of<Incidents>(context).incidents;
    locationData = Provider.of<Locations>(context).locations;
    marketingData = Provider.of<Marketing>(context).locations;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: SizedBox(
          width: 150,
          child: Image.asset(
            'assets/logo-text.png',
          ),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(UserProfileScreen.routeName),
            icon: const Icon(
              Icons.account_circle,
              size: 30,
            ),
          ),
        ],
        leading: const SizedBox(
          width: 20,
        ),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(43.3209, 21.8958),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.algo4.sicef',
          ),
          MarkerLayer(
            markers: incidentData.map((e) {
              if (e.isActive) {
                return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(e.lat, e.lng),
                    child: PrijavaWidget(
                      prijava: e,
                      icon: Icon(
                        e.type.icon,
                        color: const Color.fromRGBO(222, 76, 76, 1),
                        size: 26,
                      ),
                    ));
              } else {
                return Marker(
                  width: 0.0,
                  height: 0.0,
                  point: LatLng(e.lat, e.lng),
                  child: const SizedBox(),
                );
              }
            }).toList(),
          ),
          MarkerLayer(
            markers: locationData.map((e) {
              return Marker(
                point: LatLng(e.lat, e.lng),
                child: LocationWidget(
                  marketingModel: e,
                ),
                width: 105,
                height: 60,
              );
            }).toList(),
          ),
          MarkerLayer(
            markers: marketingData.map((e) {
              return Marker(
                point: LatLng(e.lat, e.lng),
                child: MarketingWidget(
                  marketingModel: e,
                ),
                width: 105,
                height: 60,
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(NewIncidentScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Set the border radius here
                        ),
                        backgroundColor: const Color.fromRGBO(222, 76, 76, 1),
                        minimumSize: const Size(double.maxFinite - 40, 70),
                      ),
                      child: const Text(
                        'Report incident',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
