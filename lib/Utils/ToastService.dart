import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastService {
  // Show a basic toast
  static void showToast({
    required String message,
    ToastGravity gravity = ToastGravity.TOP,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    int durationSeconds = 2,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength:
          durationSeconds == 1 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  // Show an error notification
  static void showError({
    required String message,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    showToast(
      message: message,
      gravity: gravity,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  // Show a success notification
  static void showSuccess({
    required String message,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    showToast(
      message: message,
      gravity: gravity,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}

// Example usage in a Flutter widget:
// ElevatedButton(
//   onPressed: () {
//     ToastService.showSuccess(
//       message: "Operation Successful!",
//       gravity: ToastGravity.CENTER,
//     );
//   },
//   child: Text("Show Success Toast"),
// )

// ElevatedButton(
//   onPressed: () {
//     ToastService.showError(
//       message: "Something went wrong!",
//       gravity: ToastGravity.CENTER,
//     );
//   },
//   child: Text("Show Error Toast"),
// )
