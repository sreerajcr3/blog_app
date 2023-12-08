import 'dart:io';

import 'package:blog_app/Appfunctions/appfunctions.dart';
import 'package:blog_app/screens/Screens/Blog/BlogDetailPage.dart';
import 'package:blog_app/screens/model/blogModel.dart';
import 'package:blog_app/screens/model/useridModel.dart';
import 'package:blog_app/screens/widgets/widets%20and%20functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Favorites extends StatefulWidget {
  final int? index;
  const Favorites({this.index, super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late Box favoriteBox;
  late Box userId;
  late Box blogBox;
  int? indx;
  bool isbox = false;

  @override
  void initState() {
    super.initState();
    blogBox = Hive.box('blog');
    favoriteBox = Hive.box('favorite');
    userId = Hive.box('userid');
    userIndexIdentification().then((value) {
      setState(() {
        indx = value;
      });
    });
    checkLoggedinFavorite(context);
  }

  int favoriteCount(blogindex){
    int count = 0;
    for(int i = 0;i < favoriteBox.length ; i++){
   final favorite  =   favoriteBox.getAt(i) as favorites;
      if(favorite != null && indx ==favorite.userIndex){
          count++;
      }
    }
    return count;
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
            child:
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                  valueListenable:favoriteBox.listenable() ,
                  builder: (context, value, child) {
                    final favoriteCounts = favoriteCount(indx);
                    return Apptext(words: 'Favorites  (${favoriteCounts})');
                  },
                  ),
              ],
            )
            ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              
              valueListenable: favoriteBox.listenable(),
              builder: (BuildContext context, Box<dynamic> value, Widget? child) =>
               ListView.builder(
                itemCount: favoriteBox.length,
                itemBuilder: (ctx, index) {
                  var blog = favoriteBox.getAt(index) as favorites;
                  final details = blogBox.getAt(blog.blogIndex) as Blog;
                  debugPrint("A=$indx");
            
                  if (blog.userIndex == indx) {
                    //checks the userlogged index is same as index with the user added the blog to the favoritebox
            
                    debugPrint('userindex:${blog.userIndex.toString()}');
                  
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => BlogPage(blog: details),
                        ),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                details.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(onPressed: (){
                              favoriteBox.deleteAt(index);
                            }, icon: Icon(Icons.delete,color: Colors.white,))
                          ],
                        ),
                          leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: FileImage(
                            File(
                             details.imagePath.toString(),
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
          ),
        ],
      ),
    );
  }
}
