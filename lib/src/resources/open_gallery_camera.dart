import 'package:image_picker/image_picker.dart';

class HandleGalleryAndCamera {
  Future<XFile?> handleChooseFromCamera() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );

    return file;
  }

  Future<XFile?> handleChooseFromGallery() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    return file;
  }
}
