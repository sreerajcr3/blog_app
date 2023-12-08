// ignore_for_file: prefer_const_constructors

import 'package:blog_app/screens/Screens/user/Loginpage.dart';
import 'package:blog_app/screens/model/comment_model.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future<void> deleteBlog(index) async {
  late Box blogBox = Hive.box('blog');
  late Box commentBox = Hive.box('comment');

  blogBox.deleteAt(index);
 
  for (var i = 0; i < commentBox.length; i++) {
    final deletecomment = commentBox.getAt(i) as Comment;
     if (deletecomment.blogid == index) {
      commentBox.deleteAt(i);
       
     }
  }

}

Future<void> updateBlog(
    {index,
    context,
    selectedDate,
    title,
    updatedImagePath,
    description,
    value}) async {
  late Box blogBox = Hive.box('blog');

// final blog  =  Blog(
//         date: selectedDate.toString(),
//         title: title,
//         imagePath: updatedImagePath,
//         description: description,
  //   );

  blogBox.putAt(index, value);

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('updated successfully'),
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
  ));
}

Future<void> updateObjectInMultipleBoxes(context) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Updated successfully in multiple boxes'),
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
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
