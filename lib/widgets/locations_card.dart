import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/services/network_services.dart';

// ignore: must_be_immutable
class LocationCard extends StatelessWidget {
  final Function(String userId) dismiss;
  LocationModel locationData;

  LocationCard({required this.locationData, required this.dismiss, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Slidable(
        key: Key(locationData.id),
        endActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                dismiss(locationData.id);
              },
              backgroundColor: Colors.red[400]!,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(16),
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF3D3D3D),
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locationData.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_pin_circle,
                      color: Colors.white70,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FutureBuilder(
                      future: NetworkService.getAddress(
                          locationData.lat, locationData.lng),
                      builder: (context, snapshot) => Expanded(
                        child: Text(
                          snapshot.data ?? 'Loading...',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
