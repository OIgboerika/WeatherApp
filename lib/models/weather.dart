class Weather {
  final String city;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String title;
  final String icon;
  final double lat;
  final double lon;

  Weather({
    required this.city,
    required this.temperature,
    required this.title,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
    required this.description,
    required this.lat,
    required this.lon,
  });

  String get iconLink => 'https://openweathermap.org/img/wn/$icon@2x.png';

  String? get lottieAssetPath {
    switch (icon) {
      // scattered clouds
      case '03d':
      case '03n':
        return '03d.json';
      // mist
      case '50d':
      case '50n':
        return '50d.json';
      // snow
      case '13d':
      case '13n':
        return '13d.json';
      // thunderstorm
      case '11d':
      case '11n':
        return '11d.json';
      default:
        return null;
    }
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      description: json['weather'][0]['description'] as String,
      title: json['weather'][0]['main'] as String,
      icon: json['weather'][0]['icon'],
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
    );
  }
}
