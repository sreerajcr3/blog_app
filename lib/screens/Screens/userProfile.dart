// ignore_for_file: prefer_const_constructors

import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProfile extends StatefulWidget {
 final int? index;
   const UserProfile({super.key,  this.index});

  @override
  State<UserProfile> createState() => _UserProfileState();
}



class _UserProfileState extends State<UserProfile> {

  late Box userId;
   
  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
    print(widget.index);
  }
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final user = userId.getAt(index ?? 0);
    return Scaffold(
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: HeadingWithIcon( index ?? 0,),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
      
          Center(
            child: CircleAvatar(
              radius: 50,
            ),
          ),         
          Apptext(words: 'Name:${user.name}'),
          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>UserProfile()));
        ],
      ),
    );
  }
}