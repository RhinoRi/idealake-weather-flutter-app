import 'package:idealake_weather_app/api_key.dart';

String appName = 'Idealake Weather App';

String appId = weatherApiKey;

String apiBaseUrl = "https://api.openweathermap.org/data/2.5/forecast?";

String searchByCelsius = "&units=metric";
String searchByFahrenheit = "&units=imperial";

String errorTextForCity = "Incorrect city name.";
String errorTextForCurrent = "Failed to fetch Data";
String noDataText = "Oops! No Data.";

String keyForSearch = "recentSearches";

String forecastTitle = "3 Days Forecast";
