import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

Future<Position> checkPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("disabled");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class WeatherServices {
  static var appId = "d22d61ede8e58acaea063577d67817e7";
  static getWeather() async {
    final positions = await checkPosition();
    print(positions);
    var response = await http.get(
        "https://api.openweathermap.org/data/2.5/onecall?lat=${positions.latitude}&lon=${positions.longitude}&units=metric&exclude=current,minutely,hourly,alerts&appid=$appId");
    var data = jsonDecode(response.body);
    return data;
  }
}
