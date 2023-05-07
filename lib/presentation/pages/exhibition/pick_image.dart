import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> pickImage() async {
  final picker = ImagePicker();
  final pickedImage =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
  File file = File(pickedImage!.path);
  return file;
}
