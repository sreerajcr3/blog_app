// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_app/screens/Screens/favorites.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
    imagePath = userId.get('imagePath');
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final user = userId.getAt(indx ?? 0);
    final imagePathForCurrentUser = userId.get(indx.toString());
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
            height: 50,
          ),
          Center(
            child: Container(
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                onTap: () async {
                  XFile? pickedImage = await pickImageFromGallery();
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                },
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(imagePathForCurrentUser.toString()),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(Icons.add_a_photo),
              ),
            ),
          ),
          SizedBox(height: 50),
          Apptext(words: 'Name :  ${user.name}'),
          Apptext(words: 'Username :  ${user.username}'),
          SizedBox(
            height: 50,
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
      //  final profilePic = userid(profilePic: imagePath, userIndex: indx);
      userId.put(indx.toString(), imagePath!);
      //  debugPrint('userindex.profilepic:  ${profilePic.userIndex?.toString()}');
    }
    return pickedImage;
  }

  Future<int> userIndexIdentification() async {
    debugPrint('f:widget.index: ${widget.index}');
    final sharedprefsUser = await SharedPreferences.getInstance();
    final u = sharedprefsUser.getInt('userindex');
    debugPrint('sharedprefsuserindex : $u');
    return u!;
  }
}
