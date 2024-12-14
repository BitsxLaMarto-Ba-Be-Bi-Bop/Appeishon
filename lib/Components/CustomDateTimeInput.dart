import 'package:flutter/material.dart';
import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:intl/intl.dart';

class CustomDateTimeInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final String label;
  final IconData? icon;

  const CustomDateTimeInput(
      {Key? key,
      required this.placeholder,
      this.label = "",
      required this.controller,
      this.icon})
      : super(key: key);

  @override
  State<CustomDateTimeInput> createState() => _CustomDateTimeInputState();
}

class _CustomDateTimeInputState extends State<CustomDateTimeInput> {
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      DateTime finalDateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      String formattedDate =
          DateFormat('yyyy-MM-dd', 'es_ES').format(finalDateTime);
      widget.controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        onTap: () => _selectDateTime(context),
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
