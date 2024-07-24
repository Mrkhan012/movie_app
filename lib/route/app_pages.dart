import 'package:get/get.dart';
import 'package:movie_apk/view/Splash_scrren.dart';
import 'package:movie_apk/view/add_movie_screen.dart';
import 'package:movie_apk/view/home_screen.dart';
import 'package:movie_apk/view/login_screen.dart';

class AppPages {
  static const INITIAL = '/splash';

  static final routes = [
    GetPage(name: '/splash', page: () => SplashScreen(), transition: Transition.fadeIn),
    GetPage(name: '/login', page: () => LoginScreen(), transition: Transition.rightToLeftWithFade),
    GetPage(name: '/home', page: () => HomeScreen(), transition: Transition.leftToRightWithFade),
    GetPage(name: '/add-movie', page: () => AddMovieScreen(), transition: Transition.zoom),
  ];
}
