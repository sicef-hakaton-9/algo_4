// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sicef_hakaton/misc/snackbar.dart';
import 'package:sicef_hakaton/misc/snackbar_enum.dart';
import 'package:sicef_hakaton/models/incident_model.dart';
import 'package:sicef_hakaton/providers/incident_provider.dart';
import 'package:sicef_hakaton/providers/currect_location_provider.dart';
import 'package:sicef_hakaton/services/incident_services.dart';

// ignore: must_be_immutable
class ChooseLocationScreen extends StatefulWidget {
  static const routeName = '/choose-location-screen';

  RouteSettings settings;

  ChooseLocationScreen({required this.settings, super.key});

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  List<Marker> _markers = [];
  bool _isLoading = false;

  IncidentModel? newIncident;

  @override
  void initState() {
    // TODO: implement initState
    newIncident = widget.settings.arguments as IncidentModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              Provider.of<CurrentLocation>(context, listen: false).location,
          initialZoom: 13.0,
          onTap: (tapPosition, point) {
            if (_markers.length == 1) _markers.clear();

            newIncident = newIncident!.copyWith(
              lat: point.latitude,
              lng: point.longitude,
            );

            setState(() {
              _markers.add(
                Marker(
                  point: point,
                  child: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              );
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.algo4.sicef',
          ),
          MarkerLayer(
            markers: _markers,
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
                      onPressed: () async {
                        if (newIncident == null || _markers.isEmpty) {
                          CustomSnackbar.show(context, SnackBarType.Error,
                              'Please fill all the fields and choose location.');
                          return;
                        }

                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          await Provider.of<Incidents>(context, listen: false)
                              .reportIncident(newIncident!);
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop("end");
                        } catch (e) {
                          print(e);
                          CustomSnackbar.show(context, SnackBarType.Error,
                              'Something went wrong. Please try again later.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Set the border radius here
                        ),
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.maxFinite - 40, 70),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeCap: StrokeCap.round,
                              ),
                            )
                          : const Text(
                              'Report incident',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
