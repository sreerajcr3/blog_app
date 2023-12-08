// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously, non_constant_identifier_names
import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  final int? index;
  const AddBlog({super.key, this.index});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _key = GlobalKey<FormState>();
  final titleContoller = TextEditingController();
  final descriptionController = TextEditingController();
  XFile? _selectedImage;

  late Box blogBox;
  late Box natureBox;
  late Box scienceBox;
  late Box entertainmentBox;
  late Box politicsBox;

  String? Title;
  String? Description;
  String? imagePath;
  int id = 0;
  var _selectedDate = DateTime.now();
  int? indx;

  String? _selectedValue = 'A';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');

    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
    checkLoggedin(context);
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
  
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: HeadingWithIcon(
          index: index,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _key,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Divider(color: Colors.white),
                      ),
                      Subtitle(words: 'Add your Blog'),
                      Container(
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            XFile? pickedImage = await pickImageFromGallery();
                            setState(() {
                              _selectedImage = pickedImage;
                            });
                          },
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(_selectedImage!.path),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 400,
                                  ),
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  size: 48,
                                ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          items: [
                            DropdownMenuItem(
                              child: dropdownText('select the category'),
                              value: 'A',
                            ),
                            DropdownMenuItem(
                              value: 'nature',
                              child: dropdownText('Nature'),
                            ),
                            DropdownMenuItem(
                              value: 'science',
                              child: dropdownText('Science'),
                            ),
                            DropdownMenuItem(
                              value: 'entertainment',
                              child: dropdownText('Entertainment'),
                            ),
                            DropdownMenuItem(
                              value: 'Politics',
                              child: dropdownText('Politics'),
                            ),
                          ],
                          value:
                              _selectedValue, // Set the value to one of the values in the items list
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                              selectedCategory = _selectedValue;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 35,
                                width: 110,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "${_selectedDate.day} - ${_selectedDate.month} - ${_selectedDate.year}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: _selectedDate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(3000));
                                  if (dateTime != null) {
                                    setState(() {
                                      _selectedDate = dateTime;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(30),
                                  ),
                                  side:
                                      BorderSide(width: 2, color: Colors.white),
                                  backgroundColor: Colors.transparent,
                                ),
                                child: Text('Select date'))
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Apptext(words: 'Add title'),
                      ),
                      testformfield(
                        controller: titleContoller,
                        hintTest: 'Title is required',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'title is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Apptext(words: 'Add description'),
                      ),
                      descriptionfield(descriptionController),
                      SizedBox(
                        height: 20,
                      ),
                      Button(
                        child: Text('Save'),
                        onLongPress: () {},
                        onPressed: () {
                          if (_key.currentState!.validate() &&
                              _selectedValue != null &&
                              _selectedValue != 'A' &&
                              titleContoller.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty &&
                              imagePath != null) {
                            saveData(
                                _key,
                                _selectedValue,
                                _selectedDate,
                                titleContoller,
                                imagePath,
                                descriptionController,
                                indx,
                                selectedCategory,
                                context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Select Category'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              margin: EdgeInsets.all(20),
                            ));
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: footerText(
                            words: 'Copyright © owned by Sreeraj CR'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
