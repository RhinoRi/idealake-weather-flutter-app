import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idealake_weather_app/core/constants/app_strings.dart';

import '../global/global_variables.dart';

class ApiServices {
  Future<dynamic> fetchCurrentLocationData({
    required double lat,
    required double long,
  }) async {
    // print("in api service: $displayByFahrenheit");
    String urlForCurrLoc = "${apiBaseUrl}lat=$lat&lon=$long&appid=$appId";

    displayByFahrenheit = await getTempUnitValue();

    if (displayByFahrenheit) {
      final response =
          await http.get(Uri.parse(urlForCurrLoc + searchByFahrenheit));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(errorTextForCurrent);
      }
    } else {
      final response =
          await http.get(Uri.parse(urlForCurrLoc + searchByCelsius));
      // print(urlForCurrLoc + searchByCelsius);
      // print(response.body);
      if (response.statusCode == 200) {
        // print("DATA:  ${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception(errorTextForCurrent);
      }
    }
  }
// https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
// https://api.openweathermap.org/data/2.5/forecast?lat=37.4219983&lon=-122.084&appid=08f35a907c4d4f89c564cdbf4d94b796&units=metric

  Future<dynamic> fetchSearchedCityData({required String city}) async {
    String urlForSearchedCity = "${apiBaseUrl}q=$city&appid=$appId";

    displayByFahrenheit = await getTempUnitValue();

    if (displayByFahrenheit) {
      final response =
          await http.get(Uri.parse(urlForSearchedCity + searchByFahrenheit));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(errorTextForCity);
      }
    } else {
      final response =
          await http.get(Uri.parse(urlForSearchedCity + searchByCelsius));
      if (response.statusCode == 200) {
        // print("DATA:  ${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception(errorTextForCity);
      }
    }
  }

// https://api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}
}
