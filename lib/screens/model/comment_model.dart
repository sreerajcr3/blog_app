import 'package:blog_app/screens/model/useridModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'comment_model.g.dart';

@HiveType(typeId: 3)
class Comment extends HiveObject {
  @HiveField(0)
  final String comment;

  @HiveField(1)
  final userid user;

  @HiveField(2)
  final int? blogid;

  @HiveField(3)
  final String date;

 @HiveField(4)
  final String key;

 @HiveField(5)
   String? commentCount;



 

  String? get name => user.name ?? 'Unknown';
  Image get profilePic => Image.network(user.profilePic.toString());

  Comment(   {required this.comment, required this.user,  this.blogid,required this.date,required this.key,this.commentCount, });
}
