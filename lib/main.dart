import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_apk/controller/authentication_Controller.dart';
import 'package:movie_apk/route/app_pages.dart';
import 'package:movie_apk/view/home_screen.dart';
import 'package:movie_apk/view/login_screen.dart';
import 'package:movie_apk/view/add_movie_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(
      AuthController()); // Ensure AuthController is initialized before the app starts
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
