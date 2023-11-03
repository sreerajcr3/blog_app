// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_app/screens/Screens/BlogDetailPage.dart';
import 'package:blog_app/screens/Screens/Home.dart';
import 'package:blog_app/screens/Screens/Loginpage.dart';
import 'package:blog_app/screens/Screens/addBlog.dart';
import 'package:blog_app/screens/Screens/editPage.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  final int? index;
  const Categories({super.key, required this.index});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Box natureBox;
  late Box scienceBox;
  late Box entertainmentBox;
  late Box politicsBox;
  String? selectedCategory = 'nature';
  Box<dynamic>? box;

  final List<DropdownMenuItem<String>> _categories = [
    DropdownMenuItem(value: 'nature', child: Text('Nature')),
    DropdownMenuItem(value: 'science', child: Text('Science')),
    DropdownMenuItem(value: 'entertainment', child: Text('Entertainment')),
    DropdownMenuItem(value: 'politics', child: Text('Politics')),
  ];

  @override
  void initState() {
    super.initState();
    natureBox = Hive.box<dynamic>('nature');
    entertainmentBox = Hive.box<dynamic>('entertainment');
    scienceBox = Hive.box('science');
    politicsBox = Hive.box<dynamic>('politics');
    box = natureBox;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: HeadingWithIcon(),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: Container(
              height: 30,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Align(
                child: DropdownButton(
                    items: _categories,
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        switch (selectedCategory) {
                          case 'nature':
                            box = natureBox;
                            break;

                          case 'science':
                            box = scienceBox;
                            break;

                          case 'entertainment':
                            box = entertainmentBox;
                            break;

                          case 'politics':
                            box = politicsBox;
                            break;
                        }
                      });
                    }),
              ),
            ),
          ),
          box != null && box!.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: box?.length,
                    itemBuilder: (ctx, index) {
                      final blog = box?.getAt(index) as Blog;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => BlogPage(
                                          blog: blog,
                                        )));
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.file(
                                      File(blog.imagePath),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TitleText(words: blog.title),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (ctx) => EditPage(
                                                    title: blog.title,
                                                    description:
                                                        blog.description,
                                                    image: blog.imagePath,
                                                    blog: blog,
                                                    index: index,
                                                    selectedDate: blog.date),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 500,
                  child: Align(
                    alignment: Alignment.center,
                    child: AppText(
                        words:
                            'No blogs Related to this category,Add new Blog? Click here',
                        action: () {
                          checkLoggedin();
                        }),
                  ),
                )
        ],
      ),
    );
  }

  Future<void> checkLoggedin() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savedkey);
    if (userLoggedIn == false || userLoggedIn == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AddBlog()));
    }
  }
}
