import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';

class CustomDropDown extends StatefulWidget {
  final String placeholder;
  final String label;
  final IconData? icon;
  final List<String> items;
  final List<String> values;
  final TextEditingController controller;

  const CustomDropDown({
    Key? key,
    required this.placeholder,
    this.label = "",
    this.icon,
    required this.items,
    required this.values,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedItem;

  @override
  void initState() {
    widget.controller.text = widget.values[0];
    selectedItem = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        onChanged: (value) {
          setState(() {
            selectedItem = value;
            widget.controller.text = value ?? "";
          });
        },
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: widget.icon != null
              ? Icon(widget.icon, color: CustomColors.primary)
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
        ),
      ),
    );
  }
}
