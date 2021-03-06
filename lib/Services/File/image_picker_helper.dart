import 'package:image_picker/image_picker.dart';

Future<PickedFile> pickImageFromGallery() async {
  PickedFile image =
      await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  return image;
}
