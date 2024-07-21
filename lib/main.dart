import 'package:flutter/material.dart';
import 'package:weather_app/note.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColorDark: Colors.white),
      debugShowCheckedModeBanner: false,
      home: const MainPanel(),
    );
  }
}
