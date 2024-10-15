import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                elevation: 0,
              ),
              child: const Text(
                'Map',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
