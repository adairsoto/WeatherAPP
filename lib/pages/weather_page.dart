import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:superapp/models/weather_model.dart';
import 'package:superapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('a893097daaa9bd424910f5e9376bddb8');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _weather != null
                  ? const Icon(Icons.location_pin, color: Colors.grey)
                  : const Text(''),
              Text(_weather?.cityName ?? '',
                  style: GoogleFonts.acme(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 25),
              _weather == null
                  ? Lottie.asset('assets/loading.json')
                  : Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              const SizedBox(height: 20),
              Text(_weather != null ? '${_weather?.temperature.round()}ºC' : '',
                  style: GoogleFonts.acme(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 5),
              Text(_weather?.mainCondition ?? "",
                  style: GoogleFonts.acme(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 70),
              GestureDetector(
                child: const Icon(Icons.logout, color: Colors.grey),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
