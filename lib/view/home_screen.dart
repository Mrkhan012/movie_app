import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_apk/controller/authentication_Controller.dart';
import 'package:movie_apk/controller/movie_controller.dart';
import 'package:movie_apk/utils/app_decoration.dart';
import 'package:movie_apk/utils/color.dart';
import 'package:movie_apk/utils/theme.dart';
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
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                                50), // Adjust the radius as needed
                            child: Image.file(
                              File(movie.posterUrl),
                              width: 50, // Adjust the width as needed
                              height: 50, // Adjust the height as needed
                              fit: BoxFit.cover,
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
                            duration: Duration(seconds: 3),
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
        onPressed: () => Get.to(const AddMovieScreen()),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor:
                kDefaultBlueColor, // Background color of the dialog
            buttonTheme: const ButtonThemeData(
              buttonColor: kDefaultBlueColor, // Background color of the buttons
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color of the buttons
              ),
            ),
          ),
          child: AlertDialog(
            title: const Text(
              'Confirm Logout',
              style: TextStyle(color: Colors.white), // Title text color
            ),
            content: const Text(
              'Are you sure you want to logout?',
              style: TextStyle(color: Colors.white), // Content text color
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  // Perform logout
                  authController.signOut();
                  // Navigate back to the login screen
                  Get.offAllNamed('/login');
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }
}
