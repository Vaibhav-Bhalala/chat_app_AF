import 'dart:io';
import 'package:get/get.dart';
import '../Model/Image_picker_model.dart';

class ImagePickerController extends GetxController {
  ImagePickerModel imagePickerModel = ImagePickerModel();

  void pickImage({required File pickedImage}) {
    imagePickerModel.image = pickedImage;
    update();
  }
}
