import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';


class temp_loc extends StatefulWidget {
  const temp_loc({super.key});

  @override
  _temp_locState createState() => _temp_locState();
}

class _temp_locState extends State<temp_loc> {
  String _weatherData = '';
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Geolocator.requestPermission().then((permission) {
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium)
            .then((Position position) {
          setState(() {
            _currentPosition = position;
            _getWeather();
          });
        }).catchError((e) {
        });
      }
    });
  }

  Future<void> _getWeather() async {
    if (_currentPosition != null) {
      const apiKey = '7053f9ad815fed7ef22d4be4d0d43c8a'; // replace with your API key
      final lat = _currentPosition!.latitude;
      final lon = _currentPosition!.longitude;
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final weatherData = jsonDecode(response.body);
        setState(() {
          _weatherData = 'Weather: ${weatherData['weather'][0]['main']}, \n'
              'Temperature: ${(weatherData['main']['temp'] - 273.15).toStringAsFixed(2)} °C';
        });
      } else {
        setState(() {
          _weatherData = 'Failed to load weather data';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_currentPosition != null)
                Text(
                  'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
                ),
              const SizedBox(height: 20),
              Text(
                _weatherData,
                style: const TextStyle(fontSize: 20,),
              ),
            ],
          );



  }
}
