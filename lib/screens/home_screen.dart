import 'package:hora/screens/ClockWidget.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:hora/screens/service.dart';


class WatchScreen extends StatelessWidget {
  @override
    WatchScreen({super.key});
  final WeatherService weatherService = WeatherService();
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return ClockWidget(weatherService: weatherService, mode);
          },
        );
      },
    );
  }
}
