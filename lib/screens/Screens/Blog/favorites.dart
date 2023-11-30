import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/BlogDetailPage.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Favorites extends StatefulWidget {
  final int? index;
  const Favorites({this.index, super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late Box favoriteBox;
  late Box userId;
  int? indx;
  bool isbox = false;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorite');
    userId = Hive.box('userid');
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = userId.getAt(indx ?? 0);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const HeadingWithIcon(),
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Apptext(words: 'Favorite List of ${user.name}'),
              ],
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favoriteBox.length,
              itemBuilder: (ctx, index) {
                var blog = favoriteBox.getAt(index);

                debugPrint("A=$indx");

                if (blog.userIndex == indx) {
                  //checks the userlogged index is same as index with the user added the blog to the favoritebox

                  debugPrint('userindex:${blog.userIndex.toString()}');
                  debugPrint(blog.title);

                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => BlogPage(blog: blog.blogId),
                      ),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            blog.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                        leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: FileImage(
                          File(
                            blog.imagePath.toString(),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
