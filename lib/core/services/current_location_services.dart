import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, show an error or return a default position
    throw Exception('Location services are disabled.');
  }

  // Check and request location permissions
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions denied, handle appropriately
      throw Exception('Location permissions are denied.');
    }
  }

  // Get the current position
  Position position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
    ),
  );
  return position;
}
