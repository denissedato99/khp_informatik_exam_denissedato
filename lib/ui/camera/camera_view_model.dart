import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraViewModel with ChangeNotifier {
  String imagePath = '';
  XFile? selectedImage;

  setImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  setImage(XFile? image) {
    selectedImage = image;
    notifyListeners();
  }
}