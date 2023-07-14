import 'dart:async';
import 'package:wear/wear.dart';
import 'package:hora/screens/model.dart';
import 'package:hora/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  final WeatherService weatherService;
  final WearMode mode;

  const ClockWidget(this.mode, {Key? key, required this.weatherService});

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late WeatherData _temperature;
  late String _hourString;
  late String _minuteString;
  late String _secondString;

  @override
  void initState() {
    super.initState();
    _temperature = WeatherData(
      cityName: '',
      temperature: 0,
      description: '',
      iconUrl: '',
    );
    _getTime();
    _getWeather();
    _secondString = DateFormat('ss').format(DateTime.now());

  }

  void _getTime() {
    final now = DateTime.now().toLocal();
    final hourFormatter = DateFormat('HH');
    final minuteFormatter = DateFormat('mm');
    final secondFormatter = DateFormat('ss');
    _hourString = hourFormatter.format(now);
    _minuteString = minuteFormatter.format(now);
    _secondString = secondFormatter.format(now);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now().toLocal();
      final hourFormatter = DateFormat('HH');
      final minuteFormatter = DateFormat('mm');
      final secondFormatter = DateFormat('ss');
      setState(() {
        _hourString = hourFormatter.format(now);
        _minuteString = minuteFormatter.format(now);
        _secondString = secondFormatter.format(now);
      });
    });
  }

  Future<void> _getWeather() async {
    try {
      final weatherData =
          await widget.weatherService.getWeather('San Juan del Rio');
      setState(() {
        _temperature = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.mode == WearMode.active
          ? const Color.fromARGB(223, 0, 0, 0)
          : Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  '${_temperature.temperature}°C',
                  style: TextStyle(
                    color: widget.mode == WearMode.active
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(207, 0, 0, 0),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _hourString,
                        style: TextStyle(
                          color: widget.mode == WearMode.active
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(207, 0, 0, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ':',
                        style: TextStyle(
                          color: widget.mode == WearMode.active
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(207, 0, 0, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: _minuteString,
                        style: TextStyle(
                          color: widget.mode == WearMode.active
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(207, 0, 0, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: _secondString,
                        style: TextStyle(
                          color: widget.mode == WearMode.active
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(207, 0, 0, 0),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Text(
                  DateFormat('EEEE').format(DateTime.now().toLocal()),
                  style: TextStyle(
                    color: widget.mode == WearMode.active
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(207, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('d').format(DateTime.now().toLocal()),
                  style: TextStyle(
                    color: widget.mode == WearMode.active
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(207, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}