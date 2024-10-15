import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  /// Determine the current position of the device.
  /// when the location services are not enabled or permissions
  /// are denied the 'future' weill return an error.
  static Future<Position> getCurrentLocation() async {
    // Check if location services are enabled on the device.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check site access permissions.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // If permissions are denied, user permission is requested.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permissions continue to be denied, an error is returned that the permissions are denied.
        return Future.error('Location permissions are denied');
      }
    }
    // If permissions are permanently denied, return an error that permissions cannot be requested again.
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // After verifying the permissions, the current location is obtained with high accuracy.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Track the location continuously
  static void trackLocation(Function(LatLng) onLocationChanged) {
    // Create a stream that continuously tracks the user's movements.
    Geolocator.getPositionStream().listen((Position position) {
      // Convert position coordinates from Position to LatLng.
      LatLng newPosition = LatLng(position.latitude, position.longitude);
      // Call the function passed as Callback to update the location in the application.
      onLocationChanged(newPosition);
    });
  }
}
