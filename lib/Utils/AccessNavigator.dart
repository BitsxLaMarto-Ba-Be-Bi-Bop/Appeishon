import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccessNavigator {
  static void goTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void goToAndReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
