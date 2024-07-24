import 'dart:convert';
import 'package:get/get.dart';
import 'package:movie_apk/model/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieController extends GetxController {
  var movies = <Movie>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMovies();
  }

  void addMovie(Movie movie) async {
    movies.add(movie);
    await saveMovies();
  }

  void deleteMovie(Movie movie) async {
    movies.remove(movie);
    await saveMovies();
  }

  Future<void> saveMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final movieList = movies.map((movie) => movie.toJson()).toList();
    await prefs.setString('movies', jsonEncode(movieList));
  }

  void loadMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final movieString = prefs.getString('movies') ?? '[]';
    final movieList = jsonDecode(movieString) as List;
    movies.assignAll(movieList.map((json) => Movie.fromJson(json)).toList());
  }
}
