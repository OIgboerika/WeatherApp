import 'package:flutter/material.dart';
import 'package:weatherapp2/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final VoidCallback onTap;

  const WeatherCard({
    Key? key,
    required this.weather,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                weather.city,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${weather.temperature.round()}°C',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(weather.description),
            ],
          ),
        ),
      ),
    );
  }
}