// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';
import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/HomePage/widget.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/Screens/Blog/BlogDetailPage.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box blogBox;
  late Box favoriteBox;
  late Box commentBox;
  late Box userId;
  bool iconValue = false;

  List<dynamic> _searchResults = [];

  int? indx;
  int commentCount = 0;

  final _searchController = TextEditingController();
  final commentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
    favoriteBox = Hive.box('favorite');
    commentBox = Hive.box('comment');
    userId = Hive.box('userid');
    _searchResults = [];
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
  }

  void performSearch() {
    if (_searchController.text.isNotEmpty) {
      _searchResults = blogBox.values
          .where((blog) => blog.title.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ))
          .toList();
    }
  }

  updatedCommentCount(int count) {
    setState(() {
      commentCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: HeadingWithIcon(
          index: indx,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  hintText: 'Search here ',
                  hintStyle: TextStyle(),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    performSearch();
                  });
                },
              ),
            ),
          ),
        ),
      ),

      backgroundColor: Colors.black,
      body: Container(
          child: blogBox.isNotEmpty
              ? _searchController.text.isNotEmpty
                  ? _searchResults.isEmpty
                      ? Center(
                          child: Text('Sorry, No results found'),
                        )
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final blog = _searchResults[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => BlogPage(
                                            blog: blog,
                                          )));
                                },
                                child: ListTile(
                                  title: Text(
                                    blog.title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: SizedBox(
                                      width: 80,
                                      child: Image.file(File(blog.imagePath))),
                                ),
                              ),
                            );
                          },
                        )
                  : Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            itemCount: blogBox.length,
                            itemBuilder: (ctx, index) {
                            
                              var blog = blogBox.getAt(index) as Blog;
                              String imagePath = blog.imagePath;
                              debugPrint(blog.key);

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => BlogPage(blog: blog)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.yellow,
                                            width: 0.2,
                                            style: BorderStyle.solid)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: card( blog, imagePath, indx, context,
                                            index, updatedCommentCount,setState,favoriteBox)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
              : Center(
                  child: AppText(
                      words: 'Add new Blog? Click here..!',
                      action: () {
                        checkLoggedinHomeScreen(context);
                      }))), //
    );
  }
}
