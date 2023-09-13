// weather_model.dart
class Weather {
  final String city;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String description;

  Weather({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });
}
