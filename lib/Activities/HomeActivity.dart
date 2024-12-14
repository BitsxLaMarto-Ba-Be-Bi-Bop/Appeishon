import 'package:fibro_pred/Activities/MapPage.dart';
import 'package:fibro_pred/Activities/PredictionsPage.dart';
import 'package:fibro_pred/Components/CustomTextInput.dart';
import 'package:fibro_pred/Components/HomeMenuButton.dart';
import 'package:flutter/material.dart';

import '../Components/CustomDateTimeInput.dart';
import '../Components/CustomSelectorInput.dart';
import '../Dialogs/AddCitaDialog.dart';
import '../Utils/AccessNavigator.dart';
import '../Utils/CustomColors.dart';
import '../Utils/DialogService.dart';
import 'CitesListActivity.dart';
import 'MapActivity.dart';

class Homeactivity extends StatefulWidget {
  const Homeactivity({super.key});

  @override
  State<Homeactivity> createState() => _HomeactivityState();
}

class _HomeactivityState extends State<Homeactivity> {
  GlobalKey<AddCitaDialogState> addCitaDialogKey =
      GlobalKey<AddCitaDialogState>();
  TextEditingController dateTimeAddCitaController = TextEditingController();
  TextEditingController metgeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            HomeMenuButton(
              text: "Demana Cita",
              onPress: () {
                DialogService(context).showCustomDialog(
                    title: "Demana Cita",
                    body: AddCitaDialog(key: addCitaDialogKey),
                    onAccept: () {
                      addCitaDialogKey.currentState!.saveCita();
                      print("Accepted");
                    },
                    onCancel: () {
                      print("Cancelled");
                    });
              },
              color: Colors.green,
              icon: Icons.note_add,
            ),
            HomeMenuButton(
              text: "Les Meves Cites",
              onPress: () {
                AccessNavigator.goTo(context, CitesListActivity());
              },
              color: Colors.purple,
              icon: Icons.event_note,
            ),
            HomeMenuButton(
              text: "Predicció",
              onPress: () {
                AccessNavigator.goTo(context, PredictionsPage());
              },
              color: CustomColors.primary,
              icon: Icons.question_mark,
            ),
            HomeMenuButton(
              text: "Mapa",
              onPress: () {
                AccessNavigator.goTo(context, MapPage());
              },
              color: Colors.red,
              icon: Icons.map,
            ),
          ],
        )),
      ),
    );
  }
}
