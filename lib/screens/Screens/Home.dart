// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:blog_app/screens/Screens/BlogDetailPage.dart';
import 'package:blog_app/screens/Screens/Loginpage.dart';
import 'package:blog_app/screens/Screens/addBlog.dart';
import 'package:blog_app/screens/Screens/editPage.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

const savedkey = 'userLoggedin';

class HomeScreen extends StatefulWidget {
  final int? index;
  // const HomeScreen(this.index,{Key? key,    }) : super(key: key);
  const HomeScreen({super.key, this.index});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late Box blogBox;
  bool value = true;
  List<dynamic> _searchResults = [];

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
    _searchResults = [];
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

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    //  performSearch();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: HeadingWithIcon( index??0),
        // const Subtitle(words: 'Recent Blog posts'),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SignUp()));
      //   },
      //   child: Icon(Icons.add),

      // ),
      backgroundColor: Colors.black,

      body: Container(
        child: _searchController.text.isNotEmpty
            ? _searchResults.isEmpty? Center(
              child: Text('Sorry, No results found'),
            ):
            ListView.builder(
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
                            width: 80, child: Image.file(File(blog.imagePath))),
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
                        // var reversedIndex =
                        //     blogBox.length - 1 - index; // Reverse the index
                        // var blog = blogBox.getAt(reversedIndex);
                        var blog = blogBox.getAt(index);
                        String imagePath = blog.imagePath;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => BlogPage(blog: blog)));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors
                                                      .transparent, // Removes the border
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 250,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.file(
                                                  File(imagePath),
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 13, top: 15),
                                              child: Text(
                                                DateFormat('d MMM y').format(
                                                  DateTime.parse(blog.date),
                                                ),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.yellow),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TitleText(
                                                  words: blog.title,
                                                  trimmed: true,
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                EditPage(
                                                                  selectedDate:
                                                                      blog.date,
                                                                  title: blog
                                                                      .title,
                                                                  description: blog
                                                                      .description,
                                                                  image: blog
                                                                      .imagePath,
                                                                  blog: blog,
                                                                  index: index,
                                                                )));
                                                  },
                                                  icon: Icon(Icons.edit))
                                            ],
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ), //
    );
  }

  Future<void> checkLoggedin() async {
    final index = widget.index;
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savedkey);
    if (userLoggedIn == false || userLoggedIn == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AddBlog(index!,)));
    }
  }

  void refreshData() async {
    // setState(() async {
    //  blogBox.getAt(index);
    //   value = true;
    // });
  }
}
