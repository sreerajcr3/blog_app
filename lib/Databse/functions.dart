// ignore_for_file: prefer_const_constructors

import 'package:blog_app/screens/Screens/Blog/Home.dart';
import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future<void> deleteBlog(index) async {
  late Box blogBox = Hive.box('blog');
  late Box natureBox = Hive.box('nature');
  late Box scienceBox = Hive.box('science');
  late Box entertainmentBox = Hive.box('entertainment');
  late Box politicsBox = Hive.box('politics');
  if (index >= 0 && index < scienceBox.length) {
    scienceBox.deleteAt(index);
  }

  if (index >= 0 && index < natureBox.length) {
    natureBox.deleteAt(index);
  }

  if (index >= 0 && index < politicsBox.length) {
    politicsBox.deleteAt(index);
  }

  if (index >= 0 && index < entertainmentBox.length) {
    entertainmentBox.deleteAt(index);
  }
  blogBox.deleteAt(index);
}

Future<void> updateBlog(index, value, context) async {
  late Box blogBox = Hive.box('blog');
  late Box natureBox = Hive.box('nature');
  late Box scienceBox = Hive.box('science');
  late Box politics = Hive.box('blog');

  blogBox.putAt(index, value);
  scienceBox.putAt(index, value);
  natureBox.putAt(index, value);
  politics.putAt(index, value);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('updated successfully'),
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
  ));
}

Future<void> updateObjectInMultipleBoxes(
    Object object, List<Box> boxes, int index, BuildContext context) async {
  for (var box in boxes) {
    if (index >= 0 && index < box.length) {
      box.putAt(index, object);
    }
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Updated successfully in multiple boxes'),
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
  ));
}

void saveBlog(blogData, selectedCategory, getCopy, context) {
  late Box blogBox = Hive.box('blog');
  late Box natureBox = Hive.box('nature');
  late Box scienceBox = Hive.box('science');
  late Box entertainmentBox = Hive.box('entertainment');
  late Box politicsBox = Hive.box('politics');
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

  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Blog uploaded successfully'),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blue,
    margin: EdgeInsets.all(20),
  ));
}

saveUserId(_key, _nameController, _usernameController, _passwordController,
    context, userId) {
  _key.currentState!.validate();
  final id = userid(
      name: _nameController.text,
      username: _usernameController.text,
      password: _passwordController.text);
  if (id.name!.isNotEmpty &&
      id.username!.isNotEmpty &&
      id.password!.isNotEmpty) {
    userId.add(id);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
  }

  _nameController.clear();
  _usernameController.clear();
  _passwordController.clear();
}
