 import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/Screens/Blog/addBlog.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/Screens/user/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
   Future<void> checkLoggedin(context) async {
   // final index = widget.index;
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savedkey);
    if (userLoggedIn == false || userLoggedIn == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const AddBlog()));
    }
  }
   Future<void> checkLoggedinProfile(context) async {
    // final index = widget.index;
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savedkey);
    if (userLoggedIn == false || userLoggedIn == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => const UserProfile()));
    }
  }
   Future<int> userIndexIdentification() async {
   // debugPrint('f:widget.index: ${widget.index}');
    final sharedprefsUser = await SharedPreferences.getInstance();
    final u = sharedprefsUser.getInt('userindex');
    debugPrint('sharedprefsuserindex : $u');
    return u!;
  }
  