import 'package:consultix/constants.dart';
import 'package:consultix/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/polyline_helper.dart';
import '../widgets/tracking_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static String id = 'MapScreen';
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  LatLng _initialPosition = const LatLng(29.99700412438984, 31.418901883733717);

  // markers
  final Set<Marker> _markers = {};
  // Lines
  Set<Polyline> _polylines = {};
  // coordinates
  List<LatLng> polylineCoordinates = [];

  // change state of tracking
  bool _isTracking = false;

  // animation button
  AnimationController? _animationController;
  Animation<double>? _buttonAnimation;

  @override
  void initState() {
    super.initState();

    // get current location
    _getCurrentLocation();

    // animation button
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _buttonAnimation =
        Tween<double>(begin: 1.0, end: 1.12).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));
  }

  // set initial location
  _getCurrentLocation() async {
    Position position = await LocationService.getCurrentLocation();
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _startTracking() {
    setState(() {
      _isTracking = !_isTracking;

      // if user want to clear the map when start new track
      //  polylineCoordinates.clear();
      // _polylines.clear();
      // _markers.clear();
    });

    if (_isTracking) {
      // Start animation when button is pressed
      _animationController?.forward();
      // Track location using location service
      LocationService.trackLocation((LatLng newPosition) {
        setState(() {
          //Add new coordinates to the list
          _markers.add(Marker(
            markerId: MarkerId(newPosition.toString()),
            position: newPosition,
            infoWindow: const InfoWindow(title: 'Current Location'),
          ));

          polylineCoordinates.add(newPosition);
          //Create a new Polyline based on user coordinates
          _polylines =
              PolylineHelper.createColoredPolyline(polylineCoordinates);
        });

        mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
      });
    } else {
      // Reverse animation when tracking is off
      _animationController?.reverse();
    }
  }

// stop
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Track on Map'),
          backgroundColor: kPrimerColor,
        ),
        body: Stack(
          children: [
            GoogleMap(
              // Set the target location
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12,
              ),
              // Set the map controller
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              // Show markers on map
              markers: _markers,

              // Show polylines on map
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
            Positioned(
                bottom: 95,
                left: 10,
                child: ScaleTransition(
                  scale: _buttonAnimation!,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        // Change button color based on tracking status
                        color: _isTracking ? Colors.red : kPrimerColor,
                        borderRadius: BorderRadius.circular(30),
                        // shadow effect
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4))
                        ]),
                    child: TrackingButton(
                      isTracking: _isTracking,
                      onPressed: _startTracking,
                    ),
                  ),
                ))
          ],
        ));
  }
}
