import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sicef_hakaton/models/incident_model.dart';
import 'package:sicef_hakaton/services/network_services.dart';

class PrijavaWidget extends StatelessWidget {
  final IncidentModel prijava;
  final Icon icon;
  const PrijavaWidget({super.key, required this.prijava, required this.icon});

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  int tmp = prijava.upVotes - 1;
                                  prijava.copyWith(upVotes: tmp);
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.report,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            prijava.type.icon,
                            color: const Color.fromRGBO(222, 76, 76, 1),
                            size: 48,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                prijava.title,
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
                                      prijava.lat, prijava.lng),
                                  builder: (context, snapshot) => Expanded(
                                    child: Text(
                                      "${snapshot.data}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            const SizedBox(width: 20),
                            const Icon(
                              Icons.schedule,
                              color: Color.fromRGBO(222, 76, 76, 1),
                              size: 22,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              DateFormat('EEEEE, kk:mm')
                                  .format(prijava.timestamp),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                prijava.description,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              int tmp = prijava.upVotes + 1;
                              prijava.copyWith(upVotes: tmp);
                              // TODO: IncidentServices.updateInc(prijava)
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Set the border radius here
                              ),
                              backgroundColor: Colors.green,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.7, 50),
                            ),
                            child: const Text(
                              "Confirm incident",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )),
                ),
              );
            },
          );
        },
        icon: icon);
  }
}
