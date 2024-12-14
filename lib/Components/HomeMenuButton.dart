import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';

class HomeMenuButton extends StatefulWidget {
  final String text;
  final Function() onPress;
  final Color color;
  final Color bckgroundColor;
  final IconData icon;
  const HomeMenuButton(
      {super.key,
      required this.text,
      required this.onPress,
      required this.color,
      this.bckgroundColor = Colors.white,
      required this.icon});

  @override
  State<HomeMenuButton> createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      onTap: () {
        widget.onPress.call();
        isPressed = false;
      },
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: isPressed
              ? widget.bckgroundColor.makeObcure()
              : widget.bckgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: widget.color,
                  size: 48,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.color,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
