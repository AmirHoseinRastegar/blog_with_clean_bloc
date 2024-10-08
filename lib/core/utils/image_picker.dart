import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> getImage() async {
  try {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xFile != null) {
      return File(xFile.path);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
