import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:movie_apk/controller/movie_controller.dart';
import 'package:movie_apk/model/movie_model.dart';
import 'package:movie_apk/utils/color.dart';
import 'package:movie_apk/utils/theme.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final MovieController movieController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: kDefaultBlueColor,
        iconTheme: const IconThemeData(color: kAppBrightWhiteColor),
        title: Text(
          'Add Movie',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: Get.width * 0.044,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Movie Name',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: directorController,
              decoration: const InputDecoration(
                labelText: 'Director',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              ),
            ),
            const SizedBox(height: 20),
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent, // Text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0), // Padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                elevation: 5, // Shadow elevation
              ),
              child: Text(
                'Pick Image',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: Get.width * 0.044,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
             onPressed: () {
  final movie = Movie(
    id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
    name: nameController.text.isNotEmpty ? nameController.text : 'Unknown', // Handle empty name
    director: directorController.text.isNotEmpty ? directorController.text : 'Unknown', // Handle empty director
    posterUrl: _image?.path ?? '', // Ensure posterUrl is not null
  );
  movieController.addMovie(movie);
  Get.back();
},

              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: kDefaultBlueColor, // Text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0), // Padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                elevation: 5, // Shadow elevation
              ),
              child: Text(
                'Add Movie',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: Get.width * 0.044,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
