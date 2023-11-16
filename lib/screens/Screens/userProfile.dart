// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_app/screens/Screens/favorites.dart';
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

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final user = userId.getAt(index ?? 0);
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
          SizedBox(
            height: 100,
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              child: InkWell(
                onTap: () async{
                  XFile? pickedImage= await  pickImageFromGallery();setState(() {
                      _selectedImage = pickedImage;
                    });
                },

                child: _selectedImage!=null?ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(File(_selectedImage!.path),fit: BoxFit.cover,),
                ):Icon(Icons.add_a_photo)
              ),
              // child: IconButton(
              //     onPressed: ()async {
              //     XFile? pickedImage= await  pickImageFromGallery();setState(() {
              //         _selectedImage = pickedImage;
              //       });
              //     },
              //     icon: Icon(Icons.add_a_photo)),
            ),
          ),
          SizedBox(height: 50),
          Apptext(words: 'Name:${user.name}'),
          Apptext(words: 'Username:${user.username}'),
          SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => Favorites(
                      index: widget.index,
                    ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Apptext(words: 'favorites'),
                Icon(Icons.arrow_right),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<XFile?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
        imagePath = pickedImage.path;
      });
    }
    return pickedImage;
  }
}
