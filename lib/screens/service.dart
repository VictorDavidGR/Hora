
import 'package:hora/screens/model.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final _weather = WeatherFactory('05ea5421c7f3b5a848038fbb8e1cce7f');

  Future<WeatherData> getWeather(String cityName) async {
    try {
      final weather = await _weather.currentWeatherByCityName(cityName);
      return WeatherData(
        cityName: weather.areaName!,
        temperature: weather.temperature!.celsius!.toDouble().roundToDouble(),
        description: weather.weatherDescription!,
        iconUrl: weather.weatherIcon!,
      );
    } catch (e) {
      throw Exception('Error al obtener los datos del clima');
    }
  }
}

