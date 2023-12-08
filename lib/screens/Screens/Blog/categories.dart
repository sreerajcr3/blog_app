// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/BlogDetailPage.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Box natureBox;
  late Box scienceBox;
  late Box entertainmentBox;
  late Box politicsBox;
  String? selectedCategory = 'science';
  late String category;
  late Box blogBox;

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
    category = 'nature';
    blogBox = Hive.box('blog');
  }

  @override
  Widget build(BuildContext context) {
    // final index = widget.index;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: HeadingWithIcon(
            //   index: index,
            ),
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
                    value: category,
                    onChanged: (value) {
                      setState(
                        () {
                          category = value!;
                          // switch (selectedCategory) {
                          //   case 'nature':
                          //     category = 'nature';
                          //     break;

                          //   case 'science':
                          //     category = 'science';
                          //     break;

                          //   case 'entertainment':
                          //     category = 'entertainment';
                          //     break;

                          //   case 'politics':
                          //     category = 'politics';
                          //     break;
                          // }
                        },
                      );
                    }),
              ),
            ),
          ),
          // blogBox == null &&
          blogBox.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: blogBox.length,
                    itemBuilder: (ctx, index) {
                      final blog = blogBox.getAt(index);
                      if (blog.category == category) {
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
                                      children: const [
                                        //   date(blog),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child:
                                                TitleText(words: blog.title)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                            child: DescriptionText(
                                          trimmed: true,
                                          words: blog.description,
                                          softwrap: false,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      Container(
                        color: Colors.cyan,
                        height: 300,
                        child: Text(
                          'data',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                      return null;
                    },
                  ),
                )
              : SizedBox(
                  height: 500,
                  child: Center(
                    child: AppText(
                        words: 'Sorry no blogs. Add new Blog? Click here',
                        action: () {
                          checkLoggedin(context);
                        }),
                  ),
                )
        ],
      ),
    );
  }
}
