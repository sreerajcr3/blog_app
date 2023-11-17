 import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGallery() async {
   
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // setState(() {
      //   var _selectedImage = pickedImage;
      //   imagePath = pickedImage.path;
      // });
    }
    return pickedImage;
  }