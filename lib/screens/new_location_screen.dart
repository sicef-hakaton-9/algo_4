import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sicef_hakaton/misc/snackbar.dart';
import 'package:sicef_hakaton/misc/snackbar_enum.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/providers/location_provider.dart';
import 'package:sicef_hakaton/providers/currect_location_provider.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class NewLocationScreen extends StatefulWidget {
  static const routeName = '/new-location-screen';

  const NewLocationScreen({super.key});

  @override
  State<NewLocationScreen> createState() => _NewLocationScreenState();
}

class _NewLocationScreenState extends State<NewLocationScreen> {
  List<Marker> _markers = [];
  bool _isLoading = false;
  bool _isTitleValid = true;

  LocationModel newLocation = LocationModel(
    id: 'id',
    title: '',
    lat: 0.0,
    lng: 0.0,
    userId: NetworkService.auth.currentUser!.uid,
    fcmToken: '',
  );

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

            newLocation = newLocation.copyWith(
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
                Container(
                  height: 60,
                  width: double.maxFinite - 40,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _isTitleValid = value.isNotEmpty;
                      });
                      newLocation = newLocation.copyWith(
                        title: value,
                      );
                    },
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0.0),
                      errorText: _isTitleValid ? null : '',
                      isDense: true,
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide:
                            BorderSide(color: Colors.red[400]!, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: Colors.red[400]!,
                          width: 2.0,
                        ),
                      ),
                      iconColor: Colors.white,
                      fillColor: Colors.white,
                      labelText: 'Title',
                      hintText: 'What happend? (briefly)',
                      labelStyle: const TextStyle(
                          color: Colors.white), // Set label text color to white
                      hintStyle: const TextStyle(
                          color:
                              Colors.white38), // Set hint text color to white
                    ),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white), // Set input text color to white
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_markers.isEmpty || !_isTitleValid) {
                          CustomSnackbar.show(context, SnackBarType.Error,
                              'Please fill the title field and choose location.');
                          return;
                        }

                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          Provider.of<Locations>(context, listen: false)
                              .create(newLocation);
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop("end");
                        } catch (e) {
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
                        minimumSize: const Size(double.maxFinite, 70),
                      ),
                      child: FutureBuilder(
                          future: NetworkService.messaging.getToken(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              newLocation = newLocation.copyWith(
                                fcmToken: snapshot.data,
                              );
                            }
                            return _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  )
                                : const Text(
                                    'Create location',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  );
                          }),
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
