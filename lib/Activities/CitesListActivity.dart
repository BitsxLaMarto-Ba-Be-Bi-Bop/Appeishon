import 'dart:convert';
import 'package:fibro_pred/Components/CustomButton.dart';
import 'package:fibro_pred/Utils/AccessNavigator.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Dialogs/AddCitaDialog.dart';
import '../Objects/Cita.dart';
import '../Utils/CitesService.dart';
import '../Utils/DialogService.dart';
import '../Utils/ToastService.dart';
import '../Utils/WebService/WebService.dart';
import '../Utils/WebService/WebServicesVariables.dart';

class CitesListActivity extends StatefulWidget {
  const CitesListActivity({super.key});

  @override
  State<CitesListActivity> createState() => _CitesListActivityState();
}

class _CitesListActivityState extends State<CitesListActivity> {
  GlobalKey<AddCitaDialogState> addCitaDialogKey =
      GlobalKey<AddCitaDialogState>();
  List<dynamic> citas = [];

  @override
  void initState() {
    initCitas();
    super.initState();
  }

  initCitas() async {
    await WebService(baseUrl: WebServicesVariables.BASE_URL)
        .get("appoinments/mine/", true)
        .then((value) {
      if (value.statusCode != 200) {
        ToastService.showError(message: "Error getting Citas!");
        print(value.body);
      } else {
        List<dynamic> newCitas = jsonDecode(value.body);
        setState(() {
          citas = newCitas;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back, size: 30),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Les Teves Cites",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.primary,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Custombutton(
                      text: "Afegeix Cita",
                      onPress: () {
                        DialogService(context).showCustomDialog(
                          title: "Demana Cita",
                          body: AddCitaDialog(key: addCitaDialogKey),
                          onAccept: () {
                            addCitaDialogKey.currentState!
                                .saveCita()
                                .then((value) {
                              initCitas();
                            });
                          },
                          onCancel: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: citas.isNotEmpty
                    ? ListView.builder(
                        itemCount: citas.length,
                        itemBuilder: (context, index) {
                          final cita = citas[index];
                          final appointmentDate =
                              DateTime.parse(cita["appointment_date"]);
                          final remainingTime =
                              appointmentDate.difference(DateTime.now());

                          Color iconColor = remainingTime > Duration(days: 1)
                              ? Colors.green
                              : remainingTime.isNegative
                                  ? Colors.grey
                                  : Colors.red;

                          String timeLeft = remainingTime.isNegative
                              ? ''
                              : remainingTime.inDays > 0
                                  ? '${remainingTime.inDays}d'
                                  : '${remainingTime.inHours}h';

                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: ListTile(
                              title: Text(
                                cita["reason"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.primary),
                              ),
                              subtitle: Text(
                                formatDateTime(cita["appointment_date"]),
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (timeLeft.isNotEmpty)
                                    Text(
                                      timeLeft,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: iconColor),
                                    ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.hourglass_bottom,
                                    color: iconColor,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "No hi ha cites programades",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }
}
