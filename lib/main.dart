import 'package:flutter/material.dart';

import 'screens/image_screen.dart';
import 'screens/main_screen.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const Consultix());
}

class Consultix extends StatelessWidget {
  const Consultix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consultix',
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => const MainScreen(),
        MapScreen.id: (context) => const MapScreen(),
        ImageScreen.id: (context) => const ImageScreen(),
      },
    );
  }
}
