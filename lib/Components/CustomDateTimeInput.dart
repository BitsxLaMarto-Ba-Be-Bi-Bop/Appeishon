import 'dart:convert';

import 'package:fibro_pred/Utils/WebService/WebService.dart';
import 'package:flutter/material.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../Utils/WebService/WebServicesVariables.dart';

class CustomDateTimeInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool isDateTime;

  const CustomDateTimeInput(
      {Key? key,
      required this.placeholder,
      this.label = "",
      required this.controller,
      this.icon,
      this.isDateTime = false})
      : super(key: key);

  @override
  State<CustomDateTimeInput> createState() => _CustomDateTimeInputState();
}

class _CustomDateTimeInputState extends State<CustomDateTimeInput> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES');
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      if (widget.isDateTime) {
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (selectedTime != null) {
          DateTime finalDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          String formattedDate =
              DateFormat('dd-MM-yyyy HH:mm').format(finalDateTime);
          widget.controller.text = formattedDate;
        }
      } else {
        String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        widget.controller.text = formattedDate;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        onTap: () async {
          FocusScope.of(context).unfocus();
          await _selectDateTime(context);
        },
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
