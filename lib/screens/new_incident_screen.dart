import 'package:flutter/material.dart';
import 'package:sicef_hakaton/models/incident_model.dart';
import 'package:sicef_hakaton/models/incident_type.dart';
import 'package:sicef_hakaton/screens/choose_location_screen.dart';

class NewIncidentScreen extends StatefulWidget {
  static const routeName = '/new-incident-screen';
  const NewIncidentScreen({super.key});

  @override
  State<NewIncidentScreen> createState() => _NewIncidentScreenState();
}

class _NewIncidentScreenState extends State<NewIncidentScreen> {
  List<String> incidentTypes = [
    'Incident type...',
    ...IncidentType.values.map((e) => e.name).toList()
  ];
  String _selectedItem = 'Incident type...';

  IncidentModel newIncident = IncidentModel(
    id: '',
    title: '',
    type: IncidentType.Other,
    lat: 0,
    lng: 0,
    description: '',
    timestamp: DateTime.now(),
    isActive: true,
  );

  bool _isTitleValid = true;
  bool _isTypeValied = true;
  bool _isDescriptionValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(width: 150, child: Image.asset('assets/logo-text.png')),
      ),
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    SizedBox(
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _isTitleValid = value.isNotEmpty;
                          });
                          newIncident = newIncident.copyWith(
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
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
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
                              color: Colors
                                  .white), // Set label text color to white
                          hintStyle: const TextStyle(
                              color: Colors
                                  .white38), // Set hint text color to white
                        ),
                        style: const TextStyle(
                            fontSize: 16,
                            color:
                                Colors.white), // Set input text color to white
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 60,
                      child: DropdownButtonFormField<String>(
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                                color: _isTypeValied
                                    ? Colors.white
                                    : Colors.red[400]!,
                                width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                                color: _isTypeValied
                                    ? Colors.white
                                    : Colors.red[400]!,
                                width: 2.0),
                          ),
                        ),
                        dropdownColor: const Color.fromARGB(255, 69, 69, 69),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        alignment: Alignment.topLeft,
                        elevation: 0,
                        value: _selectedItem,
                        items: incidentTypes.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (dynamic selectedItem) {
                          if (selectedItem == null ||
                              selectedItem.isEmpty ||
                              selectedItem == 'Incident type...') {
                            setState(() {
                              _isTypeValied = false;
                            });
                          }

                          setState(() {
                            _isTypeValied = true;
                            _selectedItem = selectedItem.toString();
                          });
                          newIncident = newIncident.copyWith(
                            type: IncidentType.values.firstWhere((element) =>
                                element.name == selectedItem.toString()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 240,
                      child: TextField(
                        maxLines: 10, // Set the maximum number of lines to 10
                        decoration: InputDecoration(
                          errorText: _isDescriptionValid ? null : '',
                          errorStyle: const TextStyle(height: 0.0),
                          isDense: true,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
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
                          labelText: 'Description',
                          hintText: 'What happened? (elaborate)',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          hintStyle: const TextStyle(
                            color: Colors.white38,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isDescriptionValid = value.isNotEmpty;
                          });
                          newIncident = newIncident.copyWith(
                            description: value,
                          );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 180,
                ),
                GestureDetector(
                  onTap: () {
                    if (newIncident.title.isEmpty) {
                      setState(() {
                        _isTitleValid = false;
                      });
                    } else {
                      setState(() {
                        _isTitleValid = true;
                      });
                    }

                    if (newIncident.description.isEmpty) {
                      setState(() {
                        _isDescriptionValid = false;
                      });
                    } else {
                      setState(() {
                        _isDescriptionValid = true;
                      });
                    }

                    if (_selectedItem == "Incident type...") {
                      setState(() {
                        _isTypeValied = false;
                      });
                    } else {
                      setState(() {
                        _isTypeValied = true;
                      });
                    }

                    if (!(_isTypeValied &&
                        _isTitleValid &&
                        _isDescriptionValid)) return;

                    print(newIncident.toString());

                    Navigator.of(context)
                        .pushNamed(
                      ChooseLocationScreen.routeName,
                      arguments: newIncident,
                    )
                        .then(
                      (response) {
                        if (response == "end") {
                          Navigator.of(context).pop();
                        }
                      },
                    );
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                        child: Text(
                      'Choose location',
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
