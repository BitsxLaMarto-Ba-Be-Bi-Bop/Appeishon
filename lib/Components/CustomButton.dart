import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';

class Custombutton extends StatefulWidget {
  final String text;
  final Function() onPress;
  final double round;
  final Color color;
  final Color textColor;
  final bool shadow;

  const Custombutton({
    super.key,
    required this.text,
    required this.onPress,
    this.round = 8,
    this.color = CustomColors.primary,
    this.textColor = Colors.white,
    this.shadow = true,
  });

  @override
  State<Custombutton> createState() => _CustombuttonState();
}

class _CustombuttonState extends State<Custombutton> {
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
        decoration: BoxDecoration(
          color:
              isPressed ? widget.color.makeObcure() : widget.color.withValues(),
          borderRadius: BorderRadius.circular(widget.round), // Rounded borders
          boxShadow: widget.shadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 2, // Spread of shadow
                    blurRadius: 8, // Blur effect
                    offset: Offset(0, 4), // Shadow position
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.text,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
