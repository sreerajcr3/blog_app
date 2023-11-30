// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:blog_app/screens/Screens/Blog/widgets/widget.dart';
import 'package:intl/intl.dart';
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
    // selectedDate = widget.selectedDate.toString() ;
    blogBox = Hive.box('blog');
    natureBox = Hive.box('nature');
    scienceBox = Hive.box('science');
    entertainmentBox = Hive.box('entertainment');
    politicsBox = Hive.box('politics');
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
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
                      DateFormat('d MMM y').format(
                        DateTime.parse(widget.selectedDate.toString()),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            DateButton(context, selectedDate, setState)
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
                  editPageTitleField(_titleController),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text('Description')),
                  ),
                  editPageDescriptionfield(_descriptionController)
                ],
              ),
            ),
          ),
          updateButton(_updatedImage, selectedDate, _titleController,
              _descriptionController, index, context, widget.blog.imagePath,_key),
          SizedBox(
            height: 30,
          ),
          deleteButton(context, index),
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
}
