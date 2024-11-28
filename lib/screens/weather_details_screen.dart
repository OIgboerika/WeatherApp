import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp2/models/weather.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;
  const WeatherDetailsScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          weather.city,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                Color.fromRGBO(104, 188, 220, 1),
                Color.fromRGBO(90, 147, 247, 1),
              ]),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Center(
                      child: weather.lottieAssetPath != null
                          ? Lottie.asset('assets/weather/${weather.lottieAssetPath}', width: 150, height: 150)
                          : Image.network(
                              weather.iconLink,
                              height: 150,
                              width: 150,
                            )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(.7), width: 2)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 52,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Today, ${(DateFormat('dd MMMM')).format(DateTime.now())}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${weather.temperature}°C',
                            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            weather.description,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.air,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Wind ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        '|',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 12),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.water_drop_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Hum ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        '|',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 12),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${weather.windSpeed} m/s',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${weather.humidity}%',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
