// ignore_for_file: unused_field

import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/favorites.dart';
import 'package:blog_app/screens/Screens/user/editUserprofile.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  final int? index;
  const UserProfile({super.key, this.index});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Box userId;
  String? imagePath;
  XFile? _selectedImage;
  int? indx;
  int? index1;
  userid? userlogged;

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');

    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
    // imagePath = userId.get('imagePath');
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final user = userId.getAt(indx ?? 0);
    userlogged = user;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: HeadingWithIcon(
          index: index,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              width: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: user.profilePic != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(File(userlogged!.profilePic!))
                      // ),
                      )
                  : const Icon(Icons.add_a_photo),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => EditProfile(
                          index: indx!,
                          user: user,
                          ProfilePicPath: user.profilePic ?? ' no image',
                        )));
              },
              child: const Text('edit profile')),
          const SizedBox(height: 50),
          TitleText(
            words: 'Name : ${user.name}',
            trimmed: true,
          ),
          Apptext(
            words: 'Username :  ${user.username}',
            trimmed: true,
          ),
          const SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => Favorites(
                      index: widget.index,
                    ))),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Apptext(words: 'favorites'),
                Icon(
                  Icons.arrow_right_sharp,
                  size: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<XFile?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(
        () {
          _selectedImage = pickedImage;
          imagePath = pickedImage.path;
        },
      );
    }
    return pickedImage;
  }

 
}
