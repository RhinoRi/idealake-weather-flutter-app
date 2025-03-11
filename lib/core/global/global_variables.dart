import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_strings.dart';

bool displayByFahrenheit = false;

Position? currentPosition;

/// Date...
String getMonthInWords(DateTime date) {
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[date.month - 1];
}

/// Temperature Unit...
Future<void> storeTempUnitValue(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFahrenheit', value);
}

Future<bool> getTempUnitValue() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFahrenheit') ?? false;
}

/// City Search History...
Future<List<String>> getRecentSearchesLike(String query) async {
  final pref = await SharedPreferences.getInstance();
  final allSearches = pref.getStringList(keyForSearch);
  return allSearches!.where((search) => search.startsWith(query)).toList();
}

Future<void> saveToRecentSearches(String searchText) async {
  if (searchText.isEmpty) return; //Should not be null

  final pref = await SharedPreferences.getInstance();

  Set<String> allSearches = pref.getStringList(keyForSearch)?.toSet() ?? {};

  allSearches = {searchText, ...allSearches};
  pref.setStringList(keyForSearch, allSearches.toList());
}
