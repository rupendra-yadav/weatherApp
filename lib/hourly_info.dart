import 'package:flutter/material.dart';

class HourlyInformation extends StatelessWidget {
  final String label;
  const HourlyInformation({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 90,
      child: Card(
        elevation: 4,
        semanticContainer: true,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
