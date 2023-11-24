// ignore_for_file: camel_case_types

import 'package:blog_app/screens/model/blogModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'useridModel.g.dart';

@HiveType(typeId: 1)
class userid extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? username;

  @HiveField(2)
  final String? password;

  @HiveField(3)
  final String? likedBlogs;

  @HiveField(4)
  final int? userIndex;

  @HiveField(5)
  final String? profilePic;

  userid(
      {this.profilePic,
      this.userIndex,
      this.likedBlogs,
      this.name,
      this.username,
      this.password});
}



@HiveType(typeId: 2)
class favorites extends HiveObject {
  @HiveField(0)
  final Blog? blogId;

  @HiveField(1)
  int userIndex;
  
  String get title => blogId!.title;
  Image get imagePath => Image.network(blogId!.imagePath);

  favorites({this.blogId, required this.userIndex});
}
