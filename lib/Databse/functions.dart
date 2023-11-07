
import 'package:blog_app/screens/model/blogModel.dart';
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

Future<void> updateBlog(index,value,context) async{
 
  late Box blogBox = Hive.box('blog');
  late Box natureBox = Hive.box('nature');
  late Box scienceBox = Hive.box('science');
  late Box entertainmentBox = Hive.box('entertainment');
  late Box politicsBox = Hive.box('politics');
      blogBox.putAt(index, value);

      if (index >= 0 && index < scienceBox.length) {
        scienceBox.putAt(index, value);
      }

      if (index >= 0 && index < natureBox.length) {
        natureBox.putAt(index, value);
      }

      if (index >= 0 && index < politicsBox.length) {
        politicsBox.putAt(index, value);
      }

      if (index >= 0 && index < entertainmentBox.length) {
        entertainmentBox.putAt(index, value);
      }
      else {
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('updated successfully'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ));
      
    } 




