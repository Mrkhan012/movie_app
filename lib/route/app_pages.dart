import 'package:get/get.dart';
import 'package:movie_apk/view/Splash_scrren.dart';
import 'package:movie_apk/view/add_movie_screen.dart';
import 'package:movie_apk/view/home_screen.dart';
import 'package:movie_apk/view/login_screen.dart';

class AppPages {
  static const INITIAL = '/splash';

  static final routes = [
        GetPage(name: '/splash', page: () => SplashScreen()),

    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/add-movie', page: () => AddMovieScreen(), transition: Transition.zoom),
  ];
}