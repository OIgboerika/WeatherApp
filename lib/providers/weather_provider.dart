import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp2/models/weather.dart';
import 'package:weatherapp2/screens/weather_details_screen.dart';
import 'package:weatherapp2/utils.dart';
import 'package:latlong2/latlong.dart';

class WeatherProvider with ChangeNotifier {
  late final AnimationController mapAnimationController;
  final MapController mapController = MapController();
  final TextEditingController searchTextController = TextEditingController();

  List<Marker> mapMarkers = [];

  WeatherProvider({required this.mapAnimationController});

  Weather? _weather;
  String? _error;
  bool _isLoading = false;
  final http.Client _client = http.Client();

  Weather? get weather => _weather;
  String? get error => _error;
  bool get isLoading => _isLoading;

  static const String apiKey = '58560dc56381eae03a0bd5263ea13616';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<void> fetchWeather(String city, BuildContext context) async {
    if (city.isEmpty) {
      _error = 'Please enter a city name';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('API Response: $data'); // Debug print

        _weather = Weather.fromJson(data);
        mapMarkers = [
          Marker(
              height: 42,
              width: 42,
              point: LatLng(_weather!.lat, _weather!.lon),
              child: const Icon(
                Icons.location_pin,
                color: CupertinoColors.destructiveRed,
                size: 42,
              )),
        ];
        notifyListeners();

        animateMapMovement(mapController, mapAnimationController, mapController.camera.center, LatLng(_weather!.lat, _weather!.lon), null, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeatherDetailsScreen(weather: _weather!),
              settings: null,
            ),
          );
        });

        _error = null;
      } else {
        print('Error Response: ${response.body}'); // Debug print
        _error = 'Failed to fetch weather data: ${response.statusCode}';
        _weather = null;
      }
    } catch (e, stackTrace) {
      print('Exception: $e\n$stackTrace'); // Debug print
      _error = 'Error: $e';
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    if (_error != null) {
      showSnackBar(_error!, context);
    }
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}
