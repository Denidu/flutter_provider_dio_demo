import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/weather_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter City:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final cityName = _cityController.text;
                weatherProvider.fetchWeatherForCity(cityName);
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            if (weatherProvider.weather != null)
              Column(
                children: [
                  Text(
                    'City: ${weatherProvider.weather!.city}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Temperature: ${weatherProvider.weather!.temperature.toStringAsFixed(2)}°C',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Humidity: ${weatherProvider.weather!.humidity.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Wind Speed: ${weatherProvider.weather!.windSpeed.toStringAsFixed(2)} m/s',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Description: ${weatherProvider.weather!.description}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
