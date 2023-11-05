import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sicef_hakaton/models/location_model.dart';
import 'package:sicef_hakaton/providers/location_provider.dart';
import 'package:sicef_hakaton/screens/new_location_screen.dart';
import 'package:sicef_hakaton/services/user_services.dart';
import 'package:sicef_hakaton/widgets/locations_card.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void dismiss(String locationId) {
    setState(() {
      myLocations.removeWhere((element) => element.id == locationId);
    });
  }

  List<LocationModel> myLocations = [];

  @override
  void initState() {
    Provider.of<Locations>(context, listen: false).fetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myLocations = Provider.of<Locations>(context).locations;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(width: 150, child: Image.asset('assets/logo-text.png')),
        actions: [
          IconButton(
            onPressed: () async => UserServices.logout()
                .then((value) => Navigator.of(context).pop()),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 42, 41, 41),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your locations',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(NewLocationScreen.routeName);
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: myLocations.length,
                  itemBuilder: (context, index) => LocationCard(
                    locationData: myLocations[index],
                    dismiss: dismiss,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
