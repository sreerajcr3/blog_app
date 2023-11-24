// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/user/userProfile.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  int index;
  final userid user;
  EditProfile({super.key, required this.index, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late Box userId;
  XFile? _selectedImage;
  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
    // final user = userId.getAt(widget.index);
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        //  AppbarContainer(),
        //  AppBar(
        //   backgroundColor: Colors.yellow,
        //   title: heading(),
        // ),
        body: Column(
          children: [
            const AppbarContainer(),
            Container(
              color: Colors.yellow,
              // Color(0xFFC7D9E7),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80)),
                    color: Colors.black),
                child: Column(
                  children: [
                    const TitleText(words: 'Edit Profile'),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                        onTap: () async {
                          XFile? pickimage = await pickImageFromGallery();
                          setState(() {
                            _selectedImage = pickimage;
                          });
                        },
                        child: _selectedImage != null
                            ? CircleAvatar(
                              radius: 50,
                                backgroundImage:
                                    FileImage(File(_selectedImage!.path)))
                            : const Icon(Icons.add)),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Name'),
                          ),
                          testformfield(
                              controller: _nameController,
                              hintTest: '',
                              validator: (value) {
                                return '';
                              }),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Username'),
                          ),
                          testformfield(
                              controller: _usernameController,
                              hintTest: '',
                              validator: (value) {
                                return '';
                              }),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Password'),
                          ),
                          testformfield(
                              controller: _passwordController,
                              hintTest: '',
                              validator: (value) {
                                return '';
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          Button(
                              child: const Text('save'),
                              onLongPress: () {},
                              onPressed: () {
                                userId.putAt(
                                    widget.index,
                                    userid(
                                        profilePic: _selectedImage!.path,
                                        name: _nameController.text,
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                        userIndex: widget.index));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const UserProfile()));
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
