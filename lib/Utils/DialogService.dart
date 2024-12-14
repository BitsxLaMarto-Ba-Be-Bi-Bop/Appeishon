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
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16), // Margen lateral
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(title),
                  ),
                body,
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                      },
                    ),
                    SizedBox(width: 8),
                    Custombutton(
                      textXPadding: 16,
                      textYPadding: -4,
                      text: acceptText,
                      onPress: () {
                        onAccept();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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
