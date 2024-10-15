import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(const Consultix());
}

class Consultix extends StatelessWidget {
  const Consultix({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Consultix',
      home: MainScreen(),
    );
  }
}
