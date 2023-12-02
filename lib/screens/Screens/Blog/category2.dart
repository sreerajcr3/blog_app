import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/BlogDetailPage.dart';
import 'package:blog_app/screens/Screens/Blog/widgets/widget.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Category2 extends StatefulWidget {
  const Category2({super.key});

  @override
  State<Category2> createState() => _Category2State();
}

class _Category2State extends State<Category2> {
  late Box blogBox;
  List<Blog> categoryList = [];
  String? selectedCategory = 'nature';

  Future<void> getcategory() async {
    final blogBox = Hive.box('blog');

    final categorydata = blogBox.values.toList();
    categoryList.clear();
    for (final data in categorydata) {
      if (data.category == selectedCategory) {
        categoryList.add(data);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getcategory();
    blogBox = Hive.box('blog');
  }

  final List<DropdownMenuItem<String>> _categories = [
     DropdownMenuItem(value: 'nature', child: dropdownText('Nature')),
     DropdownMenuItem(value: 'science', child: dropdownText('Science')),
     DropdownMenuItem(
        value: 'entertainment', child: dropdownText('Entertainment')),
     DropdownMenuItem(value: 'politics', child: dropdownText('Politics')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const HeadingWithIcon(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dropdownText('select category'),
              DropdownButton(
               iconSize: 40,
               iconEnabledColor: Colors.white,
                dropdownColor: Colors.black,
                  items: _categories,
                  value: selectedCategory,
                  onChanged: (value) async {
                    setState(
                      () {
                        selectedCategory = value!;
                        switch (selectedCategory) {
                          case 'nature':
                            selectedCategory = 'nature';
                            break;

                          case 'science':
                            selectedCategory = 'science';
                            break;

                          case 'entertainment':
                            selectedCategory = 'entertainment';
                            break;

                          case 'politics':
                            selectedCategory = 'politics';
                            break;
                        }
                      },
                    );
                    await getcategory();
                  }),
            ],
          ),
         categoryList.isEmpty?Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Center(child: Text('data'))
           ],
         ):
          Expanded(
            child: ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (ctx, index) {
                final data = categoryList[index];
                
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => BlogPage(
                                    blog: data,
                                  )));
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.file(
                                File(data.imagePath),
                              ),
                            ),
                            Row(
                              children: [
                                date(data),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: TitleText(words: data.title)),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: DescriptionText(
                                    trimmed: true,
                                    words: data.description,
                                    softwrap: false,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
