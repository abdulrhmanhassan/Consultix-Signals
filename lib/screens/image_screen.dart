import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../constants.dart';
import '../services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});
  static String id = "ImageScreen";

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? _image;
  final picker = ImagePicker();
  List<Offset> _trackingPoints = [];
  bool _isImageSelected = false;

  // select image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isImageSelected = true;
      }
    });
  }

  // take a photo from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isImageSelected = true;
      }
    });
  }

  void startTracking() {
    LocationService.trackLocation((LatLng newPosition) {
      setState(() {
        // Search for an algorithm to convert geographic coordinates to a line on the image
        Offset point =
            Offset(newPosition.latitude * 10, newPosition.longitude * 10);
        _trackingPoints.add(point);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimerColor,
        title: const Text('Track on Image'),
      ),
      body: _image == null
          ? const Center(
              child: Text('No image selected.'),
            )
          : Stack(
              children: [
                Image.file(
                  _image!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                // points above image
                ..._trackingPoints.map((point) {
                  return Positioned(
                    left: point.dx,
                    top: point.dy,
                    child: const Icon(Icons.location_on,
                        color: Colors.red, size: 30),
                  );
                }).toList(),
              ],
            ),

      // for floating action button row
      floatingActionButton: _isImageSelected
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                // camera
                FloatingActionButton(
                  backgroundColor: kPrimerColor,
                  heroTag: 'camera_button',
                  onPressed: getImageFromCamera,
                  tooltip: 'Pick Image From Camera',
                  child: const Icon(Icons.camera_alt),
                ),

                // gallery
                FloatingActionButton(
                  backgroundColor: kPrimerColor,
                  heroTag: 'gallery_button',
                  onPressed: getImageFromGallery,
                  tooltip: 'Pick Image From Gallery',
                  child: const Icon(Icons.photo),
                ),

                // start tracking
                FloatingActionButton(
                  backgroundColor: kPrimerColor,
                  heroTag: 'start_tracking_button', //
                  onPressed: startTracking,
                  tooltip: 'Start Tracking',
                  child: const Icon(Icons.location_on),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                // camera
                FloatingActionButton(
                  backgroundColor: kPrimerColor,
                  heroTag: 'camera_button',
                  onPressed: getImageFromCamera,
                  tooltip: 'Pick Image From Camera',
                  child: const Icon(Icons.camera_alt),
                ),
                const SizedBox(
                  width: 50,
                ),
                // gallery
                FloatingActionButton(
                  backgroundColor: kPrimerColor,
                  heroTag: 'gallery_button',
                  onPressed: getImageFromGallery,
                  tooltip: 'Pick Image From Gallery',
                  child: const Icon(Icons.photo),
                ),
              ],
            ),
    );
  }
}
