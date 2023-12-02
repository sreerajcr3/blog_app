
import 'package:blog_app/Databse/functions.dart';
import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/Screens/Blog/addBlog.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/Screens/user/userProfile.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<XFile?> pickImageFromGallery() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    //   setState(() {
    //   _selectedImage = pickedImage;
    //   imagePath = pickedImage.path;
    // });
  }
  return pickedImage;
}

Future<void> checkLoggedin(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  final userLoggedIn = sharedprefs.getBool(savedkey);
  if (userLoggedIn == false || userLoggedIn == null) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  } else {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const AddBlog()));
  }
}

Future<void> checkLoggedinProfile(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  final userLoggedIn = sharedprefs.getBool(savedkey);
  if (userLoggedIn == false || userLoggedIn == null) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  } else {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const UserProfile()));
  }
}

Future<int> userIndexIdentification() async {
  final sharedprefsUser = await SharedPreferences.getInstance();
  final u = sharedprefsUser.getInt('userindex');
  debugPrint('sharedprefsuserindex : $u');
  return u ?? 0;
}

Future<bool> checkLoggedinComment(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  final userLoggedIn = sharedprefs.getBool(savedkey);
  if (userLoggedIn == false || userLoggedIn == null) {
    return false;
  }
  return true;
}

// ignore: no_leading_underscores_for_local_identifiers
void saveData(_key, _selectedValue, _selectedDate, titleContoller, imagePath,
    descriptionController, indx, selectedCategory, context) {
  Box blogBox = Hive.box('blog');
  if (_key.currentState!.validate() &&
      _selectedValue != null &&
      _selectedValue != 'A') {
    final blogData = Blog(
        date: _selectedDate.toString(),
        title: titleContoller.text,
        imagePath: imagePath!,
        description: descriptionController.text,
        userIndex: indx,
        category: selectedCategory);
    blogBox.add(blogData);

  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Select Category'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(20),
    ));
  }
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('Blog uploaded successfully'),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(20),
  ));
}

Future<bool> checkLoggedinMenu(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  final userLoggedIn = sharedprefs.getBool(savedkey);
  if (userLoggedIn == false || userLoggedIn == null) {
    return false;
  }
  return true;
}

showdialogDelete(context, index) {
  return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text('Do you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel'),
            ),
            TextButton(
                onPressed: () {
                  deleteBlog(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logged out succesfully'),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(20),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                child: const Text('ok'))
          ],
        );
      });
}

Future<void> signout(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  sharedprefs.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const LoginScreen()),
      (route) => false);
}
 //   var reversedIndex = box!.length - 1 - index;
                      // final blog = box?.getAt(index) as Blog;


  Text dropdownText(text){
    return Text(text,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w700,fontSize: 15,color: Colors.white),);
  }