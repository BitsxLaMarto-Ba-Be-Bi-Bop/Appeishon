import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Utils/CustomColors.dart';
import '../Utils/ToastService.dart';
import '../Utils/WebService/WebService.dart';
import '../Utils/WebService/WebServicesVariables.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<dynamic> hospitals = [];
  List<LatLng> marketLocations = [];
  LatLng initialPosition = LatLng(41.3892, 2.1134);

  @override
  void initState() {
    super.initState();
    initLocations();
  }

  initLocations() async {
    await WebService(baseUrl: WebServicesVariables.BASE_URL)
        .get("hospitals", true)
        .then((value) {
      if (value.statusCode != 200) {
        ToastService.showError(message: "Error getting Localizations!");
      } else {
        List<dynamic> newLocs = json.decode(utf8.decode(value.bodyBytes));
        print(newLocs);
        setState(() {
          hospitals = newLocs.map((e) => e["name"]).toList();
          marketLocations =
              newLocs.map((e) => LatLng(e["lat"], e["lng"])).toList();
          if (marketLocations.isNotEmpty) {
            int nearestIndex = findNearestHospital();
            hospitals.insert(0, hospitals.removeAt(nearestIndex));
            marketLocations.insert(0, marketLocations.removeAt(nearestIndex));
          }
        });
      }
    });
  }

  int findNearestHospital() {
    double minDistance = double.infinity;
    int nearestIndex = 0;

    for (int i = 0; i < marketLocations.length; i++) {
      double distance =
          Distance().as(LengthUnit.Meter, initialPosition, marketLocations[i]);
      if (distance < minDistance) {
        minDistance = distance;
        nearestIndex = i;
      }
    }
    return nearestIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CustomColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Centres Propers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            if (hospitals.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: CustomColors.primary,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Hospital mes proper: ${hospitals.first}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        locale: ui.Locale('es', 'ES'),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.primary,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: FlutterMap(
                    options: MapOptions(
                      center: initialPosition,
                      zoom: 12.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 150.0,
                            height: 150.0,
                            point: initialPosition,
                            builder: (ctx) => Icon(
                              Icons.my_location,
                              color: Colors.black,
                              size: 40.0,
                            ),
                          ),
                          ...List.generate(
                            marketLocations.length,
                            (index) => Marker(
                              width: 150.0,
                              height: 150.0,
                              point: marketLocations[index],
                              builder: (ctx) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 6.0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      hospitals[index],
                                      style: TextStyle(
                                        color: CustomColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        locale: ui.Locale('es', 'ES'),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.location_on,
                                    color:
                                        index == 0 ? Colors.blue : Colors.red,
                                    size: 40.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
