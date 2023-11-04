// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:blog_app/screens/Screens/Home.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String selectedDate;
  final Blog blog;
  final int index;

  const EditPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.blog,
    required this.index,
    required this.selectedDate,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  late Box blogBox;
  late Box natureBox;
  late Box scienceBox;
  late Box entertainmentBox;
  late Box politicsBox;
  XFile? _updatedImage;
  final _key = GlobalKey<FormState>();
  int id = 0;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    blogBox = Hive.box('blog');
    natureBox = Hive.box('nature');
    scienceBox = Hive.box('science');
    entertainmentBox = Hive.box('entertainment');
    politicsBox = Hive.box('politics');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 300,
                  child: GestureDetector(
                    onTap: () async {
                      await pickImageFromGallery();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: _updatedImage != null
                            ? Image.file(File(_updatedImage!.path))
                            : Image.file(File(widget.blog.imagePath)),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                //left: ,
                top: 0,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context, 'refresh');
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
            ],
          ),
          Row(
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
                      selectedDate.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    // Text(DateFormat('d MMM y').format(DateTime.parse(selectedDate.toString()),),style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000));

                    setState(() {
                      selectedDate = dateTime!;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30),
                    ),
                    side: BorderSide(width: 2, color: Colors.white),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text('Select date'))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.topLeft, child: Text('Title')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Description')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: null,
                      minLines: 3,
                      controller: _descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Description required";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150, right: 150),
            child: ElevatedButton(
                onPressed: () {
                  update();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: Size(20, 10),
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black),
                child: Text('update')),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150, right: 150),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text('Do you want to delete?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('cancel')),
                            TextButton(
                                onPressed: () {
                                  print("widget.index: ${widget.index}");
                                  print(
                                      "scienceBox length: ${scienceBox.length}");

                                  if (widget.index >= 0 &&
                                      widget.index < scienceBox.length) {
                                    scienceBox.deleteAt(widget.index);
                                  }

                                  if (widget.index >= 0 &&
                                      widget.index < natureBox.length) {
                                    natureBox.deleteAt(widget.index);
                                  }

                                  if (widget.index >= 0 &&
                                      widget.index < politicsBox.length) {
                                    politicsBox.deleteAt(widget.index);
                                  }

                                  if (widget.index >= 0 &&
                                      widget.index < entertainmentBox.length) {
                                    entertainmentBox.deleteAt(widget.index);
                                  }
                                  blogBox.deleteAt(widget.index);

                                  // Access the item at the specified index
                                  //  var blog = scienceBox.getAt(index);
                                  //  scienceBox.deleteAt(widget.index);
                                  // blogBox.deleteAt(widget.index);
                                  // natureBox.deleteAt(widget.index);
                                  // politicsBox.deleteAt(widget.index);

                                  // entertainmentBox.deleteAt(widget.index);
                                  // Now you can safely use the 'blog' object.

                                  // blogBox.deleteAt(widget.index);

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (ctx) => HomeScreen()));
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('deleted succesfully'),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                child: Text('ok'))
                          ],
                        );
                      }));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: Size(20, 10),
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black),
                child: Text('delete')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Divider(
              color: Colors.white60,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: footerText(words: 'Copyright © owned by Sreeraj CR')),
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
        _updatedImage = pickedImage;
        //final imagePath = pickedImage.path;
      });
    }
    return pickedImage;
  }

  void update() {
    if (_key.currentState!.validate() || _updatedImage != null) {
      final updatedImagePath = _updatedImage?.path ?? widget.blog.imagePath;

      final value = Blog(
          date: selectedDate.toIso8601String(),
          title: _titleController.text,
          imagePath: updatedImagePath,
          description: _descriptionController.text);

      blogBox.putAt(widget.index, value);

      if (widget.index >= 0 && widget.index < scienceBox.length) {
        scienceBox.putAt(widget.index, value);
      }

      if (widget.index >= 0 && widget.index < natureBox.length) {
        natureBox.putAt(widget.index, value);
      }

      if (widget.index >= 0 && widget.index < politicsBox.length) {
        politicsBox.putAt(widget.index, value);
      }

      if (widget.index >= 0 && widget.index < entertainmentBox.length) {
        entertainmentBox.putAt(widget.index, value);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('updated successfully'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You must fill all required fields'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(10),
        ),
      );
    }
  }

  //  showDialog(context: context, builder: (BuildContext (context) {
  //   return AlertDialog();
  // }));
}
