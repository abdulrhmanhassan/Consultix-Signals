import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineHelper {
  // Create a new Polyline based on user coordinates
  static Set<Polyline> createPolyline(List<LatLng> coordinates) {
    return {
      Polyline(
        polylineId: const PolylineId('tracking_route'),
        points: coordinates,
        color: Colors.blue,
        width: 8,
      )
    };
  }
}
