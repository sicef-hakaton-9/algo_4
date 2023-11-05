import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/models/marketing_model.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class LocationWidget extends StatelessWidget {
  final LocationModel? marketingModel;

  const LocationWidget({Key? key, this.marketingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                backgroundColor: Colors.blueGrey.withOpacity(0.5),
                insetPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: AspectRatio(
                    aspectRatio: 70 / 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.person_pin_circle,
                          color: Color.fromRGBO(255, 255, 255, 0.965),
                          size: 48,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              marketingModel?.title ?? "Title",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.location_on,
                                color: Color.fromRGBO(222, 76, 76, 1),
                                size: 22,
                              ),
                              const SizedBox(width: 20),
                              FutureBuilder(
                                future: NetworkService.getAddress(
                                    marketingModel!.lat, marketingModel!.lng),
                                builder: (context, snapshot) => Expanded(
                                  child: Text(
                                    snapshot.data ?? "Loading...",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ]),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        const Spacer(),
                        const SizedBox(height: 10),
                      ],
                    )),
              ),
            );
          },
        );
      },
      icon: Expanded(
        child: Column(
          children: [
            Text(
              marketingModel?.title ?? "Title",
              style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.965),
                  fontSize: 8,
                  fontWeight: FontWeight.w100),
            ),
            const SizedBox(height: 2),
            const Icon(
              Icons.location_on,
              color: Color.fromRGBO(255, 255, 255, 0.965),
              size: 26,
            ),
          ],
        ),
      ),
      iconSize: 48,
    );
  }
}
