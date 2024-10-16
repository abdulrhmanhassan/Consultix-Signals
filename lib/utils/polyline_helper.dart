import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineHelper {
  // Create a new Polyline based on user coordinates with changing colors
  static Set<Polyline> createColoredPolyline(List<LatLng> coordinates) {
    List<Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow];
    List<Polyline> polylineSegments = [];

    for (int i = 1; i < coordinates.length; i++) {
      polylineSegments.add(Polyline(
        polylineId: PolylineId('polyline_segment_$i'),
        points: [coordinates[i - 1], coordinates[i]],
        color: colors[i % colors.length],
        width: 12,
      ));
    }
    return polylineSegments.toSet();
  }
}
