import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_provider_dio_demo/Models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  final Dio _dio = Dio();
  

  Future<void> fetchWeatherForCity(String cityName) async {
    try {
      final response = await _dio.get(
        'https://api.tomorrow.io/v4/weather/forecast?location=42.3478,-71.0466&apikey=SMorobbKjjrlG4g3At3CMK4a0bMgPUyf',
        queryParameters: {
          'q': cityName,
          'appid': 'SMorobbKjjrlG4g3At3CMK4a0bMgPUyf',
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final weather = Weather(
          city: data['name'],
          temperature: data['main']['temp'],
          humidity: data['main']['humidity'],
          windSpeed: data['wind']['speed'],
          description: data['weather'][0]['description'],
        );
        _weather = weather;
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      throw Exception('Failed to load weather data: $error');
    }
  }
}
