import 'package:fibro_pred/Components/CustomButton.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';

class DialogService {
  final BuildContext context;

  DialogService(this.context);

  Future<void> showCustomDialog({
    String title = "",
    required Widget body,
    required VoidCallback onAccept,
    VoidCallback? onCancel,
    String acceptText = 'Accept',
    String cancelText = 'Cancel',
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: body,
          actions: <Widget>[
            Custombutton(
                shadow: false,
                color: Colors.transparent,
                textColor: CustomColors.primary,
                text: cancelText,
                onPress: () {
                  if (onCancel != null) {
                    onCancel();
                  }
                  Navigator.of(context).pop();
                }),
            Custombutton(
                text: acceptText,
                onPress: () {
                  onAccept();
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}

// Usage Example in a Widget:
// final dialogService = DialogService(context);
// dialogService.showCustomDialog(
//   title: 'Confirm Action',
//   body: 'Are you sure you want to proceed?',
//   onAccept: () => print('Accepted'),
//   onCancel: () => print('Cancelled'),
// );
