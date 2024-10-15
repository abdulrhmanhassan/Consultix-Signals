import 'package:consultix/screens/image_screen.dart';
import 'package:consultix/screens/map_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static String id = "MainScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Image.asset('assets/consult.png'),
            const Spacer(
              flex: 4,
            ),
            const Text(
              "Welcome to the Signals!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              label: "map",
              onPressed: () {
                Navigator.pushNamed(context, MapScreen.id);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              label: "image",
              onPressed: () {
                Navigator.pushNamed(context, ImageScreen.id);
              },
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
