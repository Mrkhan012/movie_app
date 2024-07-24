import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_apk/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 3 seconds
    Timer(const Duration(seconds: 5),
        () => Get.offNamed('/login') // Navigate to home screen
        // Replace with your actual home screen route
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Blackbuster Movies APP',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: Get.width * 0.04,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Version 1.0',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: Get.width * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
