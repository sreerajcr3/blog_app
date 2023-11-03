// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously
import 'dart:io';
import 'dart:math';

import 'package:blog_app/screens/Screens/Home.dart';
import 'package:blog_app/screens/Screens/Loginpage.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

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

  // String? A = 'A';
  final String B = 'B';
  // String? C = 'C';
  // String? D = 'D';

  String? _selectedValue = 'A';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
    natureBox = Hive.box('nature');
    entertainmentBox = Hive.box('entertainment');
    scienceBox = Hive.box('science');
    politicsBox = Hive.box('politics');

    // checkLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
title: const HeadingWithIcon(),
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
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        width: 190,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DropdownButton(
                            focusColor: Colors.cyan,

                            items: [
                              DropdownMenuItem(
                                child: Text('Select the category'),
                                value: 'A',
                              ),
                              DropdownMenuItem(
                                value: 'B',
                                child: Text('Nature'),
                              ),
                              DropdownMenuItem(
                                value: 'C',
                                child: Text('Entertainment'),
                              ),
                              DropdownMenuItem(
                                value: 'D',
                                child: Text('science'),
                              ),
                              DropdownMenuItem(
                                value: 'E',
                                child: Text('Politics'),
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
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 35,
                                  width: 110,
                                  
                                  decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(30)
                                  ),
                                 
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text( "${_selectedDate.day} - ${_selectedDate.month} - ${_selectedDate.year}",style: TextStyle(color: Colors.black),),
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
                                    
                                  },style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(30),),side: BorderSide(width: 2,color: Colors.white),backgroundColor: Colors.transparent ,),
                                  child: Text('Select date'))
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Apptext(words: 'Add title'),
                      ),
                     testformfield(controller: titleContoller, hintTest: 'Title is required', validator: (value){
                      if(value !.isEmpty){
                        return 'title is required';
                      }
                      return null;
                     }),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Apptext(words: 'Add description'),
                      ),
                      TextFormField(
                        maxLines: null,
                        minLines: 3,
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description required";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          Description = newValue;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter the description......',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 150, right: 150, top: 50, bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            saveData();
                            titleContoller.clear();
                            descriptionController.clear();


                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                          ),
                          child: Text('Save'),
                        ),
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

  void saveData() {
    if (_key.currentState!.validate() &&
        _selectedValue != null &&
        _selectedValue != 'A') {
      final blogData = Blog(date: _selectedDate.toString(),  title: titleContoller.text,
          imagePath: imagePath!,
          description: descriptionController.text);
      
      
      blogBox.add(blogData);
      switch (selectedCategory) {
        case 'B':
          natureBox.add(getCopy());
          break;
        case 'C':
          entertainmentBox.add(getCopy());
          break;
        case 'D':
          scienceBox.add(getCopy());
          break;
        case 'E':
          politicsBox.add(getCopy());
          break;
          
      }
       Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => HomeScreen()));

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Blog uploaded successfully'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blue,
        margin: EdgeInsets.all(20),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Category'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(20),
      ));
    }
  }

  Future<void> checkLoggedin() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savedkey);
    if (userLoggedIn == false || userLoggedIn == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AddBlog()));
    }
  }

  Blog getCopy() {
    return Blog(date: _selectedDate.toString(),  title: titleContoller.text,
          imagePath: imagePath!,
          description: descriptionController.text);
  }
}
