import 'package:flutter/cupertino.dart';

class HistoricActivity extends StatefulWidget {
  const HistoricActivity({super.key});

  @override
  State<HistoricActivity> createState() => _HistoricActivityState();
}

class _HistoricActivityState extends State<HistoricActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Historic Page"),
      ),
    );
  }
}
