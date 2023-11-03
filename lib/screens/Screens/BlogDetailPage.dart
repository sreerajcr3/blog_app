// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BlogPage extends StatefulWidget {
  final Blog blog;
  const BlogPage({super.key, required this.blog});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Box blogBox;

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      child: Image.file(
                        File(widget.blog.imagePath),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        iconSize: 30,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: 400
                        ),
                        child: Column(
                          children: [
                            TitleText(
                              words: widget.blog.title,
                              trimmed: true,
                            ),
                            DescriptionText(
                              words: widget.blog.description,
                              trimmed: true,
                            ),
                            Divider(color: Colors.white54,),
                            footerText(words: 'Copyright © owned by Sreeraj CR')
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
