import 'package:fibro_pred/Utils/CustomColors.dart';
import 'package:flutter/material.dart';

class PredictionsPage extends StatefulWidget {
  const PredictionsPage({super.key});

  @override
  State<PredictionsPage> createState() => _PredictionsPageState();
}

class _PredictionsPageState extends State<PredictionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Predictions',
            style: TextStyle(
                color: CustomColors.primary, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            PredictionCard(
              title: 'Weather Forecast',
              description: '',
              percent: 75,
            ),
            PredictionCard(
              title: 'Stock Market',
              description: '',
              percent: 50,
            ),
            PredictionCard(
              title: 'Sports Match',
              description: '',
              percent: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class PredictionCard extends StatelessWidget {
  final String title;
  final String description;
  final int percent;

  const PredictionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.percent,
  }) : super(key: key);

  Color getColor(int percent) {
    if (percent > 60) {
      return Colors.red;
    } else if (percent >= 20 && percent <= 60) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary),
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                ),
              ],
            ),
            Text(
              '$percent%',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: getColor(percent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
