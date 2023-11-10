// ignore_for_file: prefer_const_constructors

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
 final int? index;
   const UserProfile({super.key,  this.index});

  @override
  State<UserProfile> createState() => _UserProfileState();
}



class _UserProfileState extends State<UserProfile> {

  late Box userId;
    String? imagePath;
   XFile? _selectedImage;
   
  @override
  void initState() {
    super.initState();
    userId = Hive.box('userid');
  }
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final user = userId.getAt(index ?? 0);
    return Scaffold(
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: HeadingWithIcon( index ?? 0),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
      SizedBox(height: 100,),
          Center(
            child: CircleAvatar(
                
              child:IconButton(onPressed: (){
            }, icon:  Icon(Icons.add_a_photo)),
              radius: 50,
            ),
          ),  
          SizedBox(height: 50),       
          Apptext(words: 'Name:${user.name}'),
          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>UserProfile()));
        ],
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