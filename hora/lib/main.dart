import 'package:flutter/material.dart';

class Hora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTime.now().toString(), // Muestra la fecha actual
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              TimeOfDay.now().format(context), // Muestra la hora actual
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              'Número de pasos: 0', // Muestra el número de pasos (actualízalo con los datos reales)
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
