// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:blog_app/screens/Screens/favorites.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/model/useridModel.dart';
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

  const HomeScreen({super.key, this.index});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box blogBox;
  late Box favoriteBox;
  late Box commentBox;
  late Box userId;
  bool value = true;
  List<dynamic> _searchResults = [];
  int Index = 0;

  final _searchController = TextEditingController();
  final commentController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
    favoriteBox = Hive.box('favorite');
    commentBox = Hive.box('comment');
    userId = Hive.box('userid');
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
    final Index = widget.index;
    //  performSearch();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: HeadingWithIcon(
          index: Index,
        ),
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
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors
                                                          .transparent, // Removes the border
                                                      width: 0.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 250,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Image.file(
                                                      File(imagePath),
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                              Positioned(
                                                  right: 20,
                                                  top: 20,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            final values = Blog(
                                                              date: blog.date,
                                                              title: blog.title,
                                                              imagePath:
                                                                  imagePath,
                                                              description: blog
                                                                  .description,
                                                            );final f=favorites(userIndex: 1);

                                                            blog.isFavorite =
                                                                !blog
                                                                    .isFavorite;
                                                            blog.isFavorite
                                                                ? favoriteBox
                                                                    .add(values,f)
                                                                : favoriteBox
                                                                    .deleteAt(
                                                                        index);
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(Icons.favorite,
                                                          color: blog.isFavorite
                                                              ? Colors.red
                                                              : Colors.white))),
                                            ],
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
                                                  icon: Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {
                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(
                                                    //         builder: (ctx) =>
                                                    //             Favorites(
                                                    //               index: widget
                                                    //                   .index,
                                                    //             )));
                                                    // Comment();
                                                    _showCommentsSheet();
                                                  },
                                                  icon: Icon(Icons.list))
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => AddBlog(
                index: index,
              )));
    }
  }

  void _showCommentsSheet() {
    int? index = widget.index;

    _scaffoldKey.currentState?.showBottomSheet(
      (context) {
        return DraggableScrollableSheet(
          shouldCloseOnMinExtent: true,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.black,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: commentBox.length,
                      itemBuilder: (BuildContext context, int commentIndex) {
                        final comment = commentBox.getAt(commentIndex);
                        final user = userId.getAt(commentIndex);

                        return ListTile(
                          title: Text(
                            user?.name ?? 'Unknown User',
                            style: TextStyle(color: Colors.green),
                          ),
                          subtitle: Text(
                            comment?.text ?? '',
                            style: TextStyle(color: Colors.green),
                          ),
                        );
                      },
                    ),
                  ),
                  TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          final comments = commentController.text;
                          final user = userId.getAt(index!);
                          final userName = user?.name ?? 'Unknown User';
                          final commentDatas = commentData(userName, comments);
                          commentBox.add(commentDatas);
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
