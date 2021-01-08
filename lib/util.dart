import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_info.dart';

Future<List> getCurrentLocation() async {
  Position currentPosition;
  final coord = [];
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  await geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
    currentPosition = position;
  });

  coord.add(currentPosition.latitude);
  coord.add(currentPosition.longitude);

  return coord;
}

Future<WeatherInformation> fetchWeatherInfo() async {
  final coord = await getCurrentLocation();
  print(coord);

  final _apiKey = '94681ec7a848505dcb379c133fbf3d0a';

  final String params =
      'lat=${coord[0]}&lon=${coord[1]}&exclude=hourly&appid=$_apiKey';

  http.Response response = await http.get(
      Uri.encodeFull('https://api.openweathermap.org/data/2.5/onecall?$params'),
      headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return WeatherInformation.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to Load Weather information');
  }
}

String timestampToDate(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  return DateFormat('EEE, MMM d').format(date);
}

String timeStamptoToTime(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  return DateFormat('h:mm a').format(date);
}

String kelvinToCelsius(double kelvin) {
  return (kelvin - 273.15).round().toString();
}
