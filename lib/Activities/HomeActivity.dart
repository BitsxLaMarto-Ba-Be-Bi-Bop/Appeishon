import 'package:fibro_pred/Components/HomeMenuButton.dart';
import 'package:flutter/material.dart';

import '../Utils/DialogService.dart';

class Homeactivity extends StatefulWidget {
  const Homeactivity({super.key});

  @override
  State<Homeactivity> createState() => _HomeactivityState();
}

class _HomeactivityState extends State<Homeactivity> {
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
                    title: "Confirm Action",
                    body: Text("Are you sure you want to proceed?"),
                    onAccept: () {
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
              text: "test",
              onPress: () {},
              color: Colors.yellow,
              icon: Icons.abc,
            ),
            HomeMenuButton(
              text: "test",
              onPress: () {},
              color: Colors.blue,
              icon: Icons.abc,
            ),
            HomeMenuButton(
              text: "test",
              onPress: () {},
              color: Colors.red,
              icon: Icons.abc,
            ),
          ],
        )),
      ),
    );
  }
}
