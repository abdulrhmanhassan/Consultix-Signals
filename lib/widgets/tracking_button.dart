import 'package:flutter/material.dart';

import '../constants.dart';

class TrackingButton extends StatelessWidget {
  const TrackingButton(
      {super.key, required this.isTracking, required this.onPressed});

  // Tracking status
  final bool isTracking;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Change button color based on tracking status
        backgroundColor: isTracking ? Colors.red : kPrimerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(
        isTracking ? 'Stop Tracking' : 'Start Tracking',
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
