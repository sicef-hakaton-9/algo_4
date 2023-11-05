// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class TestMap extends StatefulWidget {
//   const TestMap({Key? key}) : super(key: key);

//   @override
//   State<TestMap> createState() => _TestMapState();
// }

// class _TestMapState extends State<TestMap> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Map'),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           initialCenter: const LatLng(43.3209, 21.8958),
//           initialZoom: 13.0,
//           onTap: (tapPosition, point) => print(point),
//         ),
//         children: [
//           TileLayer(
//             urlTemplate:
//                 'https://basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
//             userAgentPackageName: 'com.algo4.sicef',
//           ),
//           const MarkerLayer(markers: [
//             Marker(
//               point: LatLng(43.3209, 21.8958),
//               child: Icon(Icons.circle),
//             )
//           ]),
//         ],
//       ),
//     );
//   }
// }
