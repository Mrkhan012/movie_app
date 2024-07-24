import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_apk/controller/authentication_Controller.dart';
import 'package:movie_apk/utils/color.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final AuthController authController;

  const LogoutConfirmationDialog({required this.authController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        dialogBackgroundColor: kDefaultBlueColor, // Background color of the dialog
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
  }
}
