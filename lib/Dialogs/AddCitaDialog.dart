import 'dart:convert';

import 'package:fibro_pred/Components/CustomTextInput.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Components/CustomDateTimeInput.dart';
import '../Components/CustomSelectorInput.dart';
import '../Objects/Cita.dart';
import '../Utils/AccessNavigator.dart';
import '../Utils/CitesService.dart';
import '../Utils/ToastService.dart';
import '../Utils/WebService/WebService.dart';
import '../Utils/WebService/WebServicesVariables.dart';

class AddCitaDialog extends StatefulWidget {
  const AddCitaDialog({super.key});

  @override
  State<AddCitaDialog> createState() => AddCitaDialogState();
}

class AddCitaDialogState extends State<AddCitaDialog> {
  TextEditingController dateTimeAddCitaController = TextEditingController();
  TextEditingController metgeController = TextEditingController();
  TextEditingController moriuController = TextEditingController();

  List<dynamic> doctors = [];

  List<String> doctorsNames = [];
  List<String> doctorsIDs = [];

  @override
  void initState() {
    initDoctors();
    // TODO: implement initState
    super.initState();
  }

  initDoctors() async {
    await WebService(baseUrl: WebServicesVariables.BASE_URL)
        .get("users/doctors/", true)
        .then((value) {
      if (value.statusCode != 200) {
        ToastService.showError(message: "Error getting doctors!");
        print(value.body);
      } else {
        print(value.body);
        doctors = jsonDecode(value.body);
        List<String> newDoctorNmaes = [];
        List<String> newDoctorIDs = [];
        for (var doctor in doctors) {
          newDoctorNmaes.add(doctor["name"]);
          newDoctorIDs.add(doctor["id"].toString());
        }
        setState(() {
          doctorsNames = newDoctorNmaes;
          doctorsIDs = newDoctorIDs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: CustomDateTimeInput(
                isDateTime: true,
                placeholder: "Fecha",
                controller: dateTimeAddCitaController),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: doctorsIDs.length > 0
                ? CustomDropDown(
                    values: doctorsIDs,
                    items: doctorsNames,
                    controller: metgeController,
                    placeholder: "Metge")
                : Center(
                    child: Text(
                    "No tens mentges asignats",
                    style: TextStyle(fontSize: 16, color: CustomColors.primary),
                  )),
          ),
          CustomTextInput(
              placeholder: "Descriu el teu malestar",
              controller: moriuController),
        ],
      ),
    );
  }

  Future<void> saveCita() async {
    await WebService(baseUrl: WebServicesVariables.BASE_URL)
        .post(
            "appoinments",
            {
              "doctor_id": metgeController.text.toString(),
              "patient_id": 0,
              "appointment_date":
                  formatDate(dateTimeAddCitaController.text.toString()),
              "reason": moriuController.text.toString()
            },
            true)
        .then((value) {
      print(metgeController.text.toString());
      print(value.body);
      if (value.statusCode != 200) {
        ToastService.showError(message: "Error adding Cita!");
      } else {
        ToastService.showSuccess(message: "Cita Afegida correctament");
      }
    });
  }

  String formatDate(String dateStr) {
    // Parse the original date string
    DateTime date = DateFormat("dd-MM-yyyy HH:mm").parse(dateStr);

    // Format to ISO 8601 with milliseconds and Z timezone
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());

    return formattedDate;
  }
}
