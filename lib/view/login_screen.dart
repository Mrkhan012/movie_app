import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_apk/controller/authentication_Controller.dart';
import 'package:movie_apk/utils/color.dart';
import 'package:movie_apk/utils/theme.dart';
import 'package:movie_apk/view/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email TextField
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                      onChanged: (value) {
                        // Handle email input changes if needed
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Password TextField
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      onChanged: (value) {
                        // Handle password input changes if needed
                      },
                    ),
                    const SizedBox(height: 24.0),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kDefaultBlueColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    // Divider
                    const Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    // Continue with Google Button
                    ElevatedButton(
                      onPressed: () => authController.signInWithGoogle(),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kDefaultBlueColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Continue with Google',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: TextButton(
                onPressed: () {
                  Get.offNamed('/home'); // Navigate to home screen
                },
                child:  Text(
                  'Skip',
                style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: Get.width * 0.04,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
