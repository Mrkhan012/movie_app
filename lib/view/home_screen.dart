import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_apk/controller/authentication_Controller.dart';
import 'package:movie_apk/controller/movie_controller.dart';
import 'package:movie_apk/utils/app_decoration.dart';
import 'package:movie_apk/utils/color.dart';
import 'package:movie_apk/utils/theme.dart';
import 'package:movie_apk/widgets/logout_confromation.dart';
import 'add_movie_screen.dart';

class HomeScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());
  final AuthController authController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kDefaultBlueColor,
        iconTheme: const IconThemeData(color: kAppBrightWhiteColor),
        title: Text('Movies',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: Get.width * 0.050,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutConfirmationDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: movieController.movies.length,
          itemBuilder: (context, index) {
            final movie = movieController.movies[index];
            return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: AppDecoration.outlineGrayA.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: ListTile(
                    leading: movie.posterUrl != null
                        ? Hero(
                            tag:
                                'moviePoster_${movie.id}', // Unique tag for each movie
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(movie.posterUrl),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const Icon(Icons.image),
                    title: Text(
                      movie.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: Get.width * 0.044,
                      ),
                    ),
                    subtitle: Text(
                      movie.director,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: Get.width * 0.044,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        if (authController.firebaseUser.value != null) {
                          movieController.deleteMovie(movie);
                        } else {
                          Get.snackbar(
                            "oppos",
                            "Please log in to delete movies.",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: const Duration(seconds: 3),
                          );
                        }
                      },
                    ),
                  ),
                ));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed('/add-movie'),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        return FadeTransition(
          opacity: animation1,
          child: ScaleTransition(
            scale: animation1,
            child: LogoutConfirmationDialog(authController: authController),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
