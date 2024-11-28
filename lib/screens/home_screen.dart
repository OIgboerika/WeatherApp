import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp2/providers/weather_provider.dart';
import 'package:weatherapp2/screens/history_screen.dart';
import 'package:weatherapp2/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final WeatherProvider weatherProvider;

  @override
  initState() {
    super.initState();
    weatherProvider = WeatherProvider(
      mapAnimationController: AnimationController(duration: const Duration(milliseconds: 500), vsync: this),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ChangeNotifierProvider<WeatherProvider>.value(
            value: weatherProvider,
            child: Consumer<WeatherProvider>(builder: (context, weatherProvider, child) {
              return FlutterMap(
                mapController: weatherProvider.mapController,
                options: const MapOptions(
                  // home
                  initialCenter: LatLng(-1.947763, 30.065222),
                  interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                  initialZoom: 8,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        // "https://api.mapbox.com/styles/v1/grimnoel/cl9ba11dz000e15lay6vjaoh6/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}",
                        "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}", // street
                    subdomains: ['mt0' /* , 'mt1', 'mt2', 'mt3' */],
                    additionalOptions: const {
                      "access_token": "pk.eyJ1IjoiZ3JpbW5vZWwiLCJhIjoiY2wyYTg1a3ZuMDBhcTNvbzgybjBla2l3ZiJ9.sVECmUo6Uvrvz7mrxz_S8Q",
                    },
                    userAgentPackageName: 'com.example.weatherapp2',
                  ),
                  MarkerLayer(markers: context.watch<WeatherProvider>().mapMarkers),
                ],
              );
            }),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(16),
                  // border: Border.all(color: colors.alwaysF1F1F1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.search,
                        controller: weatherProvider.searchTextController,
                        onFieldSubmitted: (v) {
                          searchHistory.add(v.trim().toLowerCase());
                          prefs.setStringList('history', searchHistory.toList());
                          weatherProvider.fetchWeather(v.trim(), context);
                        },
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    ChangeNotifierProvider<WeatherProvider>.value(
                      value: weatherProvider,
                      builder: (context, child) {
                        if (context.watch<WeatherProvider>().isLoading) {
                          return const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 10),
                              CircularProgressIndicator(
                                backgroundColor: Color.fromRGBO(200, 200, 200, .3),
                                strokeWidth: 2,
                                // valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.history),
                      onPressed: () async {
                        String? chosen = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HistoryScreen(),
                            settings: null,
                          ),
                        );

                        if (chosen != null) {
                          weatherProvider.searchTextController.text = chosen;
                          weatherProvider.fetchWeather(chosen, context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
