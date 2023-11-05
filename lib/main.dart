import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sicef_hakaton/providers/currect_location_provider.dart';
import 'package:sicef_hakaton/providers/incident_provider.dart';
import 'package:sicef_hakaton/providers/location_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:sicef_hakaton/providers/currect_location_provider.dart';
import 'package:sicef_hakaton/providers/incident_provider.dart';
import 'package:sicef_hakaton/providers/location_provider.dart';
import 'package:sicef_hakaton/providers/marketing_provider.dart';
import 'package:sicef_hakaton/screens/auth_screen.dart';
import 'package:sicef_hakaton/screens/choose_location_screen.dart';
import 'package:sicef_hakaton/screens/home_screen.dart';
import 'package:sicef_hakaton/screens/new_incident_screen.dart';
import 'package:sicef_hakaton/screens/new_location_screen.dart';
import 'package:sicef_hakaton/screens/user_profile_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentLocation(),
        ),
        ChangeNotifierProvider(
          create: (context) => Incidents(),
        ),
        ChangeNotifierProvider(
          create: (context) => Locations(),
        ),
        ChangeNotifierProvider(
          create: (context) => Marketing(),
        ),
      ],
      child: MaterialApp(
        title: 'CityWatch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AuthScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => const HomeScreen());
            case NewIncidentScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => const NewIncidentScreen());
            case UserProfileScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => const UserProfileScreen());
            case NewLocationScreen.routeName:
              return MaterialPageRoute(
                  builder: (context) => const NewLocationScreen());
            case ChooseLocationScreen.routeName:
              return MaterialPageRoute(
                builder: (context) => ChooseLocationScreen(
                  settings: settings,
                ),
              );
          }
          return null;
        },
      ),
    );
  }
}
