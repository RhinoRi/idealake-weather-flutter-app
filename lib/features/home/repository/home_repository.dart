import 'package:idealake_weather_app/core/services/api_services.dart';
import 'package:idealake_weather_app/features/home/models/weather_model.dart';

class HomeRepository {
  final ApiServices apiServices = ApiServices();

  Future<List<WeatherModel>> fetchHomeCurrentData({
    required double lat,
    required double long,
  }) async {
    try {
      final data =
          await apiServices.fetchCurrentLocationData(lat: lat, long: long);

      final day1 = WeatherModel.fromJson(data);
      final day2 = WeatherModel.fromJson2(data);
      final day3 = WeatherModel.fromJson3(data);

      // print(data['list'][8]);

      final output = [day1, day2, day3];

      return output;
    } catch (err) {
      // print(err);
      throw Exception(err.toString());
    }
  }

  Future<List<WeatherModel>> fetchHomeSearchedData(
      {required String city}) async {
    try {
      final data = await apiServices.fetchSearchedCityData(city: city);

      final day1 = WeatherModel.fromJson(data);
      final day2 = WeatherModel.fromJson2(data);
      final day3 = WeatherModel.fromJson3(data);

      final output = [day1, day2, day3];

      return output;
    } catch (err) {
      // print(err);
      throw Exception(err.toString());
    }
  }
}
