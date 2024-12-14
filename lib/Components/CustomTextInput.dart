import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool obscure;
  const CustomTextInput(
      {super.key,
      required this.placeholder,
      this.label = "",
      required this.controller,
      this.icon = null,
      this.obscure = false});

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
            obscureText: widget.obscure,
            controller: widget.controller,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: this.widget.icon != null
                  ? Icon(this.widget.icon, color: CustomColors.primary)
                  : null,
              labelText: widget.label,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              hintText: widget.placeholder,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: CustomColors.primary, width: 2.0),
              ),
            )));
  }
}
